//
//  Factory.swift
//  RedDog
//
//  Created by Marco Antonio Flores Lopez on 10/03/21.
//

import Foundation

protocol Factory {
    
    func createSplashViewController(_ coordinator: Coordinator?) -> SplashViewController
    func createSplashViewModel() -> SplashViewModel
    
    func createMoviePoolViewController(_ coordinator: Coordinator?) -> MoviePoolViewController
    func createMoviePoolViewModel() -> MoviePoolViewModel
    
    func createMovieDetailViewController(movieId: Int, _ coordinator: Coordinator?) -> MovieDetailViewController
    func createMovieDetailViewModel() -> MovieDetailViewModel
}
