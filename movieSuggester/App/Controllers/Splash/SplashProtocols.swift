//
//  SplashProtocols.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//


import Foundation

protocol SplashViewProtocol: View {
    func showActivityIndicator()
    func stopActivityIndicator()
    func goToMoviePool()
}

protocol SplashViewModelProtocol {
    func didAppear()
}

protocol SplashUIProtocol {
    func startAnimation()
    func stopAnimation()
}
