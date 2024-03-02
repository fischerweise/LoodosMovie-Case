//
//  MovieListViewModel.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import FirebaseAnalytics

protocol MovieListViewModelDelegate: AnyObject {
    func willUpdateViewController()
    func willUpdateViewController(with message: String)
}

final class MovieListViewModel {
    
    private(set) var movies: [MovieItem] = []
    
    weak var delegate: MovieListViewModelDelegate?
    
    var title: String {
        return "Movies"
    }
    
    var errorTitle: String {
        return "There was error happened."
    }
    
    var alertButtonTitle: String {
        return "OK"
    }
    
    var numberOfItemsInSection: Int {
        return movies.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> MovieItem {
        return movies[indexPath.item]
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        let movieItem = movies[indexPath.item]
        FirebaseAnalytics.Analytics.logEvent(
            "detail_screen",
            parameters: [
                AnalyticsParameterScreenName: "movie_detail_screen",
                "movie_name": movieItem.originalTitle!
            ]
        )
    }
    
    func fetchPopularMovies() {
        NetworkManager.getPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies.results
                self?.delegate?.willUpdateViewController()
            case .failure(let error):
                self?.delegate?.willUpdateViewController(with: error.rawValue)
            }
        }
    }
    
    func searchMovies(with query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        guard !query.isEmpty else {
            movies = []
            delegate?.willUpdateViewController()
            return
        }
        NetworkManager.searchMovies(with: query) { [weak self] result in
            switch result {
            case .success(let movies):
                if movies.results.isEmpty {
                    self?.delegate?.willUpdateViewController(with: "The movie you searched was not found.")
                } else {
                    self?.movies = movies.results
                    self?.delegate?.willUpdateViewController()
                }
                
            case .failure(let error):
                self?.delegate?.willUpdateViewController(with: error.rawValue)
            }
        }
    }
    
    func emptyList() {
        movies = []
        delegate?.willUpdateViewController()
    }
}
