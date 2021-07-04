//
//  MovieDetailViewModel.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 30/06/21.
//

import Foundation

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    weak var repository: TmdbRepository?
    var config: Config?
    var view: MovieDetailViewProtocol?
    
    var movieId: Int?
    
    func didLoad() {
        if let movieId = movieId {
            repository?.getMovie(moviewId: movieId, { [weak self] movie in
                self?.view?.loadDetails(movie: movie, url: self?.repository?.getPosterUrl(name: movie.posterPath ?? "", size: self?.config?.images?.posterSizes?.last ?? "w500"))
            }, { [weak self] error in
                self?.view?.showAlert(type: .error, message: error.localizedDescription)
            })
        }
    }
}
