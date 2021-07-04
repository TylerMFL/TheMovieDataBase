//
//  SplashViewController.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
 
    var factory: DependancyContainer?
    var coordinator: MainCoordinator?

    lazy var ui: SplashView = {
        let ui = SplashView(frame: self.view.bounds)
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.delegate = self
        return ui
    }()
    
    lazy var viewModel: SplashViewModel? = {
        let viewModel = self.factory?.createSplashViewModel()
        viewModel?.view = self
        viewModel?.dependancyContainer = factory
        viewModel?.repository = factory?.tmdbRepository
        return viewModel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(factory: Factory, coordinator: Coordinator?) {
        super.init(nibName: nil, bundle: nil)
        self.factory = factory as? DependancyContainer
        self.coordinator = coordinator as? MainCoordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponents()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.didAppear()
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

extension SplashViewController: SplashViewDelegate {
    
}

extension SplashViewController: SplashViewProtocol {
    
    func goToMoviePool() {
        DispatchQueue.main.async {
            self.coordinator?.goToMoviePool()
        }
    }
    
    func showActivityIndicator() {
        ui.startAnimation()
    }
    
    func stopActivityIndicator() {
        ui.stopAnimation()
    }
}
