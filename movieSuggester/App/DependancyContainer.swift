//
//  DependancyContainer.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//

import Foundation

class DependancyContainer: Factory {

    var config: Config?
    var tmdbRepository: TmdbRepository
    
    init(apiKey: String, baseUrl: String, imagesUrl: String) {
        let tmdbConfiguration = TmdbConfiguration(apiKey: apiKey, baseUrl: baseUrl, imagesUrl: imagesUrl)
        self.tmdbRepository = TmdbRepository(configuration: tmdbConfiguration)
    }
}




