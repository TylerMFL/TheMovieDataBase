//
//  MoviePoolFactory.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//

import Foundation

extension DependancyContainer {
    
    func createMoviePoolViewController(_ coordinator: Coordinator?) -> MoviePoolViewController {
        let moviePoolViewController = MoviePoolViewController(factory: self, coordinator: coordinator)
        return moviePoolViewController
    }

    func createMoviePoolViewModel() -> MoviePoolViewModel {
        let moviePoolViewModel = MoviePoolViewModel()
        return moviePoolViewModel
    }
}
