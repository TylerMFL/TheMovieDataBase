//
//  TmdbRepository.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 01/07/21.
//

import Foundation
import UIKit

class TmdbRepository {
    
    let configuration: TmdbConfiguration
    var dataManager = DataManager()
    
    init(configuration: TmdbConfiguration) {
        self.configuration = configuration
    }
    
    func getConfiguration(_ successBlock: @escaping (_ response: Config)-> Void, _ errorBlock: @escaping (_ error: Error) -> Void) {
        
        let params: [String: Any?] = ["api_key": configuration.apiKey]
        dataManager.request(method: .GET, url: configuration.baseUrl.appending("configuration"), parameters: params, type: Config.self, nil, { response in
            successBlock(response as! Config)
        }, { error in
            errorBlock(error)
        })
    }
    
    func getGenres(_ successBlock: @escaping (_ response: GenresList)-> Void, _ errorBlock: @escaping (_ error: Error) -> Void) {
        
        let params: [String: Any?] = ["api_key": configuration.apiKey]
        dataManager.request(method: .GET, url: configuration.baseUrl.appending("/genre/movie/list"), parameters: params, type: GenresList.self, nil, { response in
            successBlock(response as! GenresList)
        }, { error in
            errorBlock(error)
        })
    }
    
    func getMostPopular(page: Int, _ successBlock: @escaping (_ response: PopularMovies)-> Void, _ errorBlock: @escaping (_ error: Error) -> Void) {
        
        let params: [String: Any?] = [
            "api_key": configuration.apiKey,
            "page": page,
            "language": "en-US"
        ]
        dataManager.request(method: .GET, url: configuration.baseUrl.appending("movie/popular"), parameters: params, type: PopularMovies.self, nil, { response in
            successBlock(response as! PopularMovies)
        }, { error in
            errorBlock(error)
        })
    }
    
    func getPosterUrl(name: String, size: String) -> URL? {
        if let url = URL(string: configuration.imagesUrl.appending("\(size)/\(name)")) {
            return url
        } else {
            return nil
        }
    }
    
    func getMovie(moviewId: Int, _ successBlock: @escaping (_ response: Movie)-> Void, _ errorBlock: @escaping (_ error: Error) -> Void) {
    
        let params: [String: Any?] = ["api_key": configuration.apiKey]
        dataManager.request(method: .GET, url: configuration.baseUrl.appending("movie/\(moviewId)"), parameters: params, type: Movie.self, nil, { response in
            successBlock(response as! Movie)
        }, { error in
            errorBlock(error)
        })
    }
}
