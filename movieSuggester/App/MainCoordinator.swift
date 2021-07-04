//
//  MainCoordinator.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//

import Foundation
import UIKit

protocol MainCoordinatorProtocol {
    func goToMoviePool()
    func goToDetails(movieId: Int)
}

class MainCoordinator: Coordinator, MainCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController?
    
    var factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
        navigationController = UINavigationController()
    }
    
    func start() {
        let splashVC = factory.createSplashViewController(self)
        navigationController.pushViewController(splashVC, animated: true)
    }
    
    func finish() { }
    
    func goToMoviePool() {
        let moviePoolVC = factory.createMoviePoolViewController(self)
        navigationController.pushViewController(moviePoolVC, animated: true)
    }
    
    func goToDetails(movieId: Int) {
        let movieDetail = factory.createMovieDetailViewController(movieId: movieId, self)
        navigationController.pushViewController(movieDetail, animated: true)
    }
}
