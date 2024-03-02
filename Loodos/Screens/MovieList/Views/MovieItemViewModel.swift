//
//  MovieItemViewModel.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import Foundation

final class MovieItemViewModel {
    private let movie: MovieItem!
    init(movie: MovieItem) {
        self.movie = movie
    }
    var movieTitle: String {
        guard let title = movie.originalTitle else { 
            return ""
        }
        return title
    }
    var posterURL: URL {
        return movie.posterURL
    }
}
