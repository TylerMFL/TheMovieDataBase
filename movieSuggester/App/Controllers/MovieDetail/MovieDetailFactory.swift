//
//  MovieDetailFactory.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 30/06/21.
//

import Foundation

extension DependancyContainer {
    
    func createMovieDetailViewController(movieId: Int, _ coordinator: Coordinator?) -> MovieDetailViewController {
        let movieDetailViewController = MovieDetailViewController(factory: self, coordinator: coordinator, movieId: movieId)
        return movieDetailViewController
    }
    
    func createMovieDetailViewModel() -> MovieDetailViewModel {
        let movieDetailViewModel = MovieDetailViewModel()
        return movieDetailViewModel
    }
}
