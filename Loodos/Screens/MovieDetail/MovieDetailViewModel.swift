//
//  MovieDetailViewModel.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import Foundation

final class MovieDetailViewModel {
    
    private let movie: MovieItem!
    
    init(movie: MovieItem) {
        self.movie = movie
    }
    
    var title: String {
        return "Movie Detail"
    }
    
    var movieTitle: String {
        guard let title = movie.originalTitle else { 
            return ""
        }
        return title
    }
    
    var overviewText: String {
        guard let overview = movie.overview else { 
            return ""
        }
        return overview
    }
    
    var posterURL: URL {
        return movie.posterURL
    }
}
