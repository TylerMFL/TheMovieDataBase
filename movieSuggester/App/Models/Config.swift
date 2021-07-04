//
//  TMDBConfig.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 01/07/21.
//

import Foundation

// MARK: - TMDBConfiguration
struct Config: Codable {
    var images: Images?
    var changeKeys: [String]?
    var genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
}

extension Config {
    mutating func setGenres(_ genres: [Genre]?) {
        self.genres = genres
    }
}

// MARK: - Images
struct Images: Codable {
    var baseURL: String?
    var secureBaseURL: String?
    var backdropSizes, logoSizes, posterSizes, profileSizes: [String]?
    var stillSizes: [String]?

    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}

