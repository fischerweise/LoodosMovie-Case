//
//  NetworkManager.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import Foundation

enum NetworkError: String, Error {
    case unableToComplete = "Unable to fulfill your request in its entirety. Kindly verify the quality of your internet connection."
    case invalidResponse = "The answer of the server is invalid. Please try again."
    case invalidData = "It was invalid data that was obtained from the server. Please try again."
}

enum NetworkManager {
    case trendingMovies
    case upcomingMovies
    case popularMovies
    case topRatedMovies
    case searchMovies(String)

    var endpoint: String {
        switch self {
        case .trendingMovies:
            return "\(APIManager.shared.baseURL)/3/trending/movie/day?api_key=\(APIManager.shared.apiKey)"
        case .upcomingMovies:
            return "\(APIManager.shared.baseURL)/3/movie/upcoming?api_key=\(APIManager.shared.apiKey)"
        case .popularMovies:
            return "\(APIManager.shared.baseURL)/3/movie/popular?api_key=\(APIManager.shared.apiKey)"
        case .topRatedMovies:
            return "\(APIManager.shared.baseURL)/3/movie/top_rated?api_key=\(APIManager.shared.apiKey)"
        case .searchMovies(let query):
            return "\(APIManager.shared.baseURL)/3/search/movie?api_key=\(APIManager.shared.apiKey)&query=\(query)"
        }
    }
    
    var url: URL { URL(string: endpoint)! }
}

extension NetworkManager {
    
    static func getTrendingMovies(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.trendingMovies.url, completion: completion)
    }
    
    static func getUpcomingMovies(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.upcomingMovies.url, completion: completion)
    }
    
    static func getPopularMovies(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.popularMovies.url, completion: completion)
    }
    
    static func getTopRatedMovies(completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.topRatedMovies.url, completion: completion)
    }
    
    static func searchMovies(with query: String, completion: @escaping (Result<MovieList, NetworkError>) -> Void) {
        NetworkManager.taskForGetRequest(url: NetworkManager.searchMovies(query).url, completion: completion)
    }
}

private extension NetworkManager {
    
    static func taskForGetRequest<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseObject = try decoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
