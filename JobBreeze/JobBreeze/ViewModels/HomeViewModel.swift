//
//  HomeViewModel.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 09/01/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    func fetchData(type: String, completion: @escaping (Result<[JobDetailsDataModel], APIError>) -> Void) {
        APIManager.shared.fetchJobs(of: type)
            .sink(receiveCompletion: { result in
                switch result{
                case .finished:
                    print("API request completed successfully")
                    break
                case .failure(let error):
                    print("API request failed with error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }, receiveValue: { data in
                print(data)
                completion(.success(data.data))
            })
            .store(in: &cancellables)
    }
}
