//
//  MoviePoolProtocols.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//


import Foundation
import UIKit

protocol MoviePoolViewProtocol: View {
    func updateMoview()
    func goToDetails(movieId: Int)
}

protocol MoviePoolViewModelProtocol {
    func validateFetch(indexPaths: [IndexPath])
    func getMovies()
}

protocol MoviePoolUIProtocol {
    func dequeueReusableCell(indexPath: IndexPath) -> UITableViewCell
    func updateTable()
}

protocol TmdbTableViewCellProtocol {
    func configure<Model>(model: Model)
}
