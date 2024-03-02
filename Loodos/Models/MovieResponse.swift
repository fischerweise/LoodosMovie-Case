//
//  MovieResponse.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import Foundation

struct MovieList: Decodable {
    let results: [MovieItem]
}

struct MovieItem: Decodable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
    let voteAverage: Double
    
    var posterURL: URL {
        URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}
