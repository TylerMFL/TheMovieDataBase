//
//  MoviePoolViewController.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//

import Foundation
import UIKit

class MoviePoolViewController: UIViewController {
 
    var factory: DependancyContainer?
    var coordinator: MainCoordinator?

    lazy var ui: MoviePoolView = {
        let ui = MoviePoolView(frame: self.view.bounds, delegate: self)
        ui.translatesAutoresizingMaskIntoConstraints = false
        return ui
    }()
    
    lazy var viewModel: MoviePoolViewModel? = {
        let viewModel = factory?.createMoviePoolViewModel()
        viewModel?.view = self
        viewModel?.dependancyContainer = factory
        viewModel?.repository = factory?.tmdbRepository
        return viewModel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(factory: Factory, coordinator: Coordinator?) {
        self.factory = factory as? DependancyContainer
        self.coordinator = coordinator as? MainCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponents()
        navigationController?.navigationBar.isHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
        viewModel?.getMovies()
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

extension MoviePoolViewController: MoviePoolViewDelegate, UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MoviePoolTableViewCell.heigth
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.popularMovies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ui.dequeueReusableCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TmdbTableViewCellProtocol, let shortMovie = viewModel?.popularMovies[indexPath.row] {
            let model = (repository: factory?.tmdbRepository, config: factory?.config, shortMovie: shortMovie)
            cell.configure(model: model)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let shortMovie = viewModel?.popularMovies[indexPath.row], let id = shortMovie.id {
            coordinator?.goToDetails(movieId: id)
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel?.validateFetch(indexPaths: indexPaths)
    }
}

extension MoviePoolViewController: MoviePoolViewProtocol {
    
    func goToDetails(movieId: Int) {
        coordinator?.goToDetails(movieId: movieId)
    }
    
    func updateMoview() {
        ui.updateTable()
    }
    
}
