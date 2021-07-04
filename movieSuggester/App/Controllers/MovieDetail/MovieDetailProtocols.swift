//
//  MovieDetailProtocols.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 30/06/21.
//


import Foundation
import UIKit

protocol MovieDetailViewProtocol: View {
    func loadDetails(movie: Movie, url: URL?)
}

protocol MovieDetailViewModelProtocol {
    func didLoad()
}

protocol MovieDetailUIProtocol {
    func loadDetails(movie: Movie, url: URL?)
}
