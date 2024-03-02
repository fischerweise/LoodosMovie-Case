//
//  APIManager.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import Foundation

class APIManager {
    
    static let shared = { APIManager() }()
    
    lazy var baseURL: String = {
        return "https://api.themoviedb.org"
    }()
    
    lazy var apiKey: String = {
        return "31c8b0e1cd21b9eeefe53a661d43c484"
    }()
    
    lazy var imageBaseUrl: String = {
        return "https://image.tmdb.org/t/p/w500/"
    }()
}

