//
//  PopularMovies.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 02/07/21.
//

import Foundation
import UIKit

// MARK: - Empty
struct PopularMovies: Codable {
    var page: Int?
    var results: [ShortMovie]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ShortMovie: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var thumbnail: UIImage?
    var genres: [String]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension ShortMovie: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    mutating func loadGenres(genresList: [Genre]) {
        self.genres = [String]()
        genreIDS?.forEach({ id in
            if let genre = genresList.first(where: { $0.id == id }), let name = genre.name, name != "" {
                self.genres?.append(name)
            }
        })
    }
}
