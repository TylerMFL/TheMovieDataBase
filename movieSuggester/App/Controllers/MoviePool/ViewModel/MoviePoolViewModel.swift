//
//  MoviePoolViewModel.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//

import Foundation

class MoviePoolViewModel: MoviePoolViewModelProtocol {
    
    weak var repository: TmdbRepository?
    weak var dependancyContainer: DependancyContainer?
    var currentPage: Int = 0
    var view: MoviePoolViewProtocol?
    
    var popularMovies: [ShortMovie] = [ShortMovie]() {
        didSet {
            view?.updateMoview()
        }
    }
    
    func getMovies() {
        currentPage += 1
        view?.showSpinner(title: "")
        repository?.getMostPopular(page: currentPage, { [weak self] popularMovies in
            self?.view?.hideSpinner(completion: {
                
                if var results = popularMovies.results, let genres = self?.dependancyContainer?.config?.genres {
                    for i in 0 ..< results.count {
                        results[i].loadGenres(genresList: genres)
                    }
                    self?.popularMovies.append(contentsOf: results)
                }
            })
        }, { [weak self] error in
            self?.view?.hideSpinner(completion: {
                self?.view?.showAlert(type: .error, message: error.localizedDescription)
            })
        })
    }
    
    func validateFetch(indexPaths: [IndexPath]) {
        if let row = indexPaths.last?.row {
            if popularMovies[row] == popularMovies.last {
                getMovies()
            }
        }
    }
}
