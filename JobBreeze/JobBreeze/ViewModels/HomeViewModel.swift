//
//  HomeViewModel.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 09/01/24.
//

import Foundation
import Combine
import Network

class HomeViewModel: ObservableObject {

    // MARK: - Properties

    @Published var isFetchingData = false
    @Published var searchText = ""
    @Published var jobEmploymentTypes = JobEmploymentType.allCases
    @Published var popularJobs: [JobDetailsDataModel] = []
    @Published var nearByJobs: [JobDetailsDataModel] = []
    @Published var showToast = false
    @Published var toastMessage = ""
    @Published var popularJobsEmptyStateContent: EmptyStateContent = .noDataAvailable
    @Published var nearByJobsEmptyStateContent: EmptyStateContent = .noDataAvailable

    @Published var isNetworkAvailable = true
    private let networkMonitor = NWPathMonitor()
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initialization

    init() {
        startMonitoringNetwork()
        fetchJobs(type: JobType.popularJobs.rawValue) { [weak self] in
            self?.fetchJobs(type: JobType.nearbyJobs.rawValue) {}
        }
    }

    // MARK: - Public Methods

    func fetchJobs(type: String, completion: @escaping () -> Void) {
        let formattedType = String(type.filter { !" ".contains($0) })
        fetchData(type: formattedType) { [weak self] result in
            switch result {
            case .success(let data):
                self?.updateJobData(type: type, data: data)
                completion()
            case .failure:
                completion()
            }
        }
    }

    // MARK: - Private Methods

    private func fetchData(type: String, completion: @escaping (Result<[JobDetailsDataModel], APIError>) -> Void) {
        guard isNetworkAvailable else {
            handleAPIError(.noInternet)
            return
        }

        guard !isFetchingData else { return }

        isFetchingData = true
        APIManager.shared.fetchJobs(of: type)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    print("API request completed successfully")
                case .failure(let error):
                    print("API request failed with error: \(error.localizedDescription)")
                    self?.handleAPIError(error)
                }
                self?.isFetchingData = false
            }, receiveValue: { data in
                print(data)
                self.isFetchingData = false
                completion(.success(data.data))
            })
            .store(in: &cancellables)
    }

    private func updateJobData(type: String, data: [JobDetailsDataModel]) {
        DispatchQueue.main.async {
            if type == JobType.popularJobs.rawValue {
                self.popularJobs = data
                self.popularJobsEmptyStateContent = data.isEmpty ? .noDataAvailable : .none
            } else {
                self.nearByJobs = data
                self.nearByJobsEmptyStateContent = data.isEmpty ? .noDataAvailable : .none
            }
        }
    }

    private func handleAPIError(_ error: APIError, for type: String? = nil) {
        DispatchQueue.main.async {
            guard let type = type else {
                self.toastMessage = error.errorMessage
                self.showToast = true
                return
            }

            if type == JobType.popularJobs.rawValue {
                self.popularJobsEmptyStateContent = self.emptyStateContent(for: error)
            } else {
                self.nearByJobsEmptyStateContent = self.emptyStateContent(for: error)
            }
        }
    }

    private func emptyStateContent(for error: APIError) -> EmptyStateContent {
        switch error {
        case .noInternet:
            return .noInternet
        case .noDataFound:
            return .noDataAvailable
        default:
            return .somethingWentWrong
        }
    }

    // MARK: - Deinitializer

    deinit {
        cancellables.forEach { $0.cancel() }
        stopMonitoring()
    }
}

// MARK: - Extensions

extension HomeViewModel {

    // MARK: - Network Monitoring

    private func startMonitoringNetwork() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isNetworkAvailable = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: DispatchQueue(label: "NetworkMonitor"))
    }

    public func stopMonitoring() {
        networkMonitor.cancel()
    }
}
