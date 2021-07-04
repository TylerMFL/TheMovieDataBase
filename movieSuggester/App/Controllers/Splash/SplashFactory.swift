//
//  SplashFactory.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//

import Foundation

extension DependancyContainer {
    
    func createSplashViewController(_ coordinator: Coordinator?) -> SplashViewController {
        let splashViewController = SplashViewController(factory: self, coordinator: coordinator)
        return splashViewController
    }

    func createSplashViewModel() -> SplashViewModel {
        let splashViewModel = SplashViewModel()
        return splashViewModel
    }
}
