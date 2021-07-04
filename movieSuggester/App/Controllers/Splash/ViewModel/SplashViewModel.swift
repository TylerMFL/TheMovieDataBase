//
//  SplashViewModel.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//

import Foundation

class SplashViewModel: SplashViewModelProtocol {
    
    weak var repository: TmdbRepository?
    weak var dependancyContainer: DependancyContainer?
    var view: SplashViewProtocol?
    
    func didAppear() {
        view?.showActivityIndicator()
        getConfiguration()
    }
    
    func getConfiguration() {
        repository?.getConfiguration({ [weak self] tmdbConfig in
            self?.dependancyContainer?.config = tmdbConfig
            self?.getGenres()
        }, { [weak self] error in
            self?.view?.showAlert(type: .error, message: error.localizedDescription)
        })
    }
    
    func getGenres() {
        repository?.getGenres({ [weak self] genresList in
            self?.dependancyContainer?.config?.setGenres(genresList.genres)
            self?.view?.goToMoviePool()
        }, { [weak self] error in
            self?.view?.showAlert(type: .error, message: error.localizedDescription)
        })
    }
}
