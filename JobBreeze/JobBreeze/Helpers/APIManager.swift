//
//  APIManager.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 12/07/23.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidURL
    case noInternet
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
    case apiError(String)
    case noDataFound

    var errorMessage: String {
        switch self {
        case .noInternet:
            return "No internet connection"
        case .noDataFound:
            return "No data found"
        case .invalidURL, .invalidResponse, .requestFailed, .decodingFailed:
            return "Something went wrong. Please try again"
        case .apiError(let message):
            return message
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class APIManager {
    static let shared = APIManager()

    private var baseURL = AppConfig.baseURL
    private var APIKey = AppConfig.apiKey
    private var APIHost = AppConfig.apiHost

    private init() {}

    // MARK: - Fetch Data

    /// Fetches data from the provided URL using the specified HTTP method and headers.
    ///
    /// - Parameters:
    ///   - url: The URL to fetch the data from.
    ///   - method: The HTTP method for the request. Default is GET.
    /// - Returns: A publisher emitting the fetched data or an APIError.
    func fetchData<T: Decodable>(from url: URL, method: HTTPMethod = .get) -> AnyPublisher<T, APIError> {
        guard let request = createRequest(for: url, method: method, headers: getHeaders()) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return APIError.decodingFailed(decodingError)
                } else {
                    return APIError.requestFailed(error)
                }
            }
            .eraseToAnyPublisher()
    }

    // MARK: - Create Request

    /// Creates a URLRequest with the provided URL, HTTP method, and headers.
    ///
    /// - Parameters:
    ///   - url: The URL for the request.
    ///   - method: The HTTP method for the request.
    ///   - headers: Optional headers to include in the request.
    /// - Returns: A URLRequest instance or nil if the URL is invalid.
    private func createRequest(for url: URL, method: HTTPMethod, headers: [String: String]?) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 30
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }

    // MARK: - Get Headers

    /// Get headers
    private func getHeaders() -> [String: String] {
        var headers: [String: String] = [:]
        headers["X-RapidAPI-Key"] = APIKey
        headers["X-RapidAPI-Host"] = APIHost
        return headers
    }

    // MARK: - Jobs API

    /// Fetches the jobs data.
    /// - Parameters:
    ///     - type: The type of jobs to be fetched
    /// - Returns: A publisher emitting an array of JobsDataModel or an APIError.
    func fetchJobs(of type: String, page: Int = 1) -> AnyPublisher<JobsDataModel, APIError> {
        let urlString = "\(baseURL)search?query=\(type)&num_pages=\(page)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        return fetchData(from: url)
    }
}
