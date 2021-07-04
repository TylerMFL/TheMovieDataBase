//
//  MovieDetailViewController.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 30/06/21.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
 
    var factory: DependancyContainer?
    var coordinator: MainCoordinator?
    
    var movieId: Int?

    lazy var ui: MovieDetailView = {
        let ui = MovieDetailView(frame: self.view.bounds)
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.delegate = self
        return ui
    }()
    
    lazy var viewModel: MovieDetailViewModel? = {
        let viewModel = factory?.createMovieDetailViewModel()
        viewModel?.view = self
        viewModel?.repository = factory?.tmdbRepository
        viewModel?.movieId = self.movieId
        viewModel?.config = factory?.config
        return viewModel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(factory: Factory, coordinator: Coordinator?, movieId: Int?) {
        self.factory = factory as? DependancyContainer
        self.coordinator = coordinator as? MainCoordinator
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponents()
        viewModel?.didLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initComponents() {
        addComponents()
        layoutComponents()
    }
    
    func addComponents() {
        view.addSubview(ui)
    }
    
    func layoutComponents() {
        NSLayoutConstraint.activate([
            ui.leftAnchor.constraint(equalTo: view.leftAnchor),
            ui.topAnchor.constraint(equalTo: view.topAnchor),
            ui.rightAnchor.constraint(equalTo: view.rightAnchor),
            ui.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension MovieDetailViewController: MovieDetailViewDelegate {
    
    func openHomePage(string: String) {
        if let url = URL(string: string) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    func loadDetails(movie: Movie, url: URL?) {
        self.title = movie.title
        ui.loadDetails(movie: movie, url: url)
    }
}
