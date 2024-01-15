//
//  JobListViewModel.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 12/01/24.
//

import Combine
import UIKit
import Network

class JobListViewModel: ObservableObject {

    // MARK: - Properties

    @Published var isInitialFetching: Bool = true
    @Published var isFetchingData: Bool = false

    @Published var jobType: String = ""
    @Published var jobList: [JobDetailsDataModel] = []
    @Published var pageCount: Int = 1

    @Published var showToast = false
    @Published var toastMessage = ""
    @Published var emptyStateContent: EmptyStateContent = .noDataAvailable

    @Published var isNetworkAvailable = true
    private let networkMonitor = NWPathMonitor()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(_ type: String) {
        jobType = type
        startMonitoringNetwork()
        refreshJobList { }
    }

    // MARK: - Refresh Data

    func refreshJobList(_ completionBlock: @escaping () -> Void) {
        isInitialFetching = false
        guard isNetworkAvailable else {
            handleAPIError(.noInternet)
            completionBlock()
            return
        }

        guard !isFetchingData else {
            completionBlock()
            return
        }

        isFetchingData = true

        APIManager.shared.fetchJobs(of: jobType, page: pageCount)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.handleAPIError(error)
                case .finished:
                    break
                }
                self?.isFetchingData = false
                completionBlock()
            }, receiveValue: { [weak self] response in
                self?.jobList = response.data
                self?.pageCount += 1
            })
            .store(in: &cancellables)
    }

    // MARK: - Load More Data

    func loadMoreJobList() {
        guard isNetworkAvailable else {
            handleAPIError(.noInternet)
            return
        }

        guard !isFetchingData else {
            return
        }

        APIManager.shared.fetchJobs(of: jobType, page: pageCount)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.handleAPIError(error)
                case .finished:
                    break
                }
                self?.isFetchingData = false
            }, receiveValue: { [weak self] response in
                self?.updateJobList(with: response.data)
                self?.pageCount += 1
            })
            .store(in: &cancellables)
    }

    private func updateJobList(with data: [JobDetailsDataModel]) {
        let newJobs = data
        var uniqueJobIDs = Set<String>()

        for (index, existingJob) in jobList.enumerated() {
            uniqueJobIDs.insert(existingJob.jobID)

            if let duplicateIndex = newJobs.firstIndex(where: { $0.jobID == existingJob.jobID }) {
                jobList[index] = newJobs[duplicateIndex]
            }
        }

        jobList.append(contentsOf: newJobs.filter { !uniqueJobIDs.contains($0.jobID) })
    }

    // MARK: - Handle API Error

    private func handleAPIError(_ error: APIError) {
        DispatchQueue.main.async {
            if self.jobList.isEmpty {
                switch error {
                case .noInternet:
                    self.emptyStateContent = .noInternet
                case .noDataFound:
                    self.emptyStateContent = .noDataAvailable
                default:
                    self.emptyStateContent = .somethingWentWrong
                }
            } else {
                self.toastMessage = error.errorMessage
                self.showToast = true
            }
        }
    }

    // MARK: - Deinitializer

    deinit {
        cancellables.forEach { $0.cancel() }
        stopMonitoring()
    }
}

extension JobListViewModel {

    // MARK: - Start the network monitoring

    private func startMonitoringNetwork() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isNetworkAvailable = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: DispatchQueue(label: "NetworkMonitor"))
    }

    // MARK: - Stop the network monitor

    public func stopMonitoring() {
        networkMonitor.cancel()
    }
}
