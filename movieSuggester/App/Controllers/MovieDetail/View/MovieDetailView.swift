//
//  MovieDetailView.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 30/06/21.
//

import Foundation
import UIKit
import Kingfisher

protocol MovieDetailViewDelegate {
    func openHomePage(string: String)
}

class MovieDetailView: UIView {
    
    lazy var scroll: UIScrollView = {
        return ControlFactory.createScrollView()
    }()
    
    lazy var stack: UIStackView = {
        let stack = ControlFactory.createSimpleStack(top: 20, left: 20, bottom: 20, right: 20)
        stack.spacing = 20
        return stack
    }()
    
    lazy var posterImage: UIImageView = {
        let posterImage = ControlFactory.createImageView(image: nil)
        posterImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return posterImage
    }()
    
    var delegate: MovieDetailViewDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setLayoutComponents()
    }
    
    private func addComponents() {
        addSubview(scroll)
        scroll.addSubview(stack)
    }
    
    private func setLayoutComponents() {
        NSLayoutConstraint.activate([
            scroll.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            scroll.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scroll.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            scroll.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            stack.leftAnchor.constraint(equalTo: scroll.leftAnchor),
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.rightAnchor.constraint(equalTo: scroll.rightAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            stack.heightAnchor.constraint(greaterThanOrEqualTo: scroll.heightAnchor),
        ])
    }
    
    @objc func goToHomePage(sender: UIButton) {
        if let delegate = delegate {
            delegate.openHomePage(string: sender.title(for: .normal) ?? "")
        }
    }
}

extension MovieDetailView : MovieDetailUIProtocol {
    
    func loadDetails(movie: Movie, url: URL?) {
        
        posterImage.kf.setImage(with: url)
        
        stack.addArrangedSubview(posterImage)
        stack.addArrangedSubview(ControlFactory.createLabel(movie.title ?? ""))
        
        var genreS: String = ""
        if let genres = movie.genres {
            for (i, g) in genres.enumerated() {
                genreS.append("\(g.name ?? "")\(i < genres.count ? " - " : "")")
            }
            stack.addArrangedSubview(ControlFactory.createLabel(genreS))
        }
        if let popularity = movie.popularity {
            stack.addArrangedSubview(ControlFactory.createLabel("Popularity: \(popularity)"))
        }
        if let releaseDate = movie.releaseDate {
            stack.addArrangedSubview(ControlFactory.createLabel("Release date: \(releaseDate)"))
        }
        if let overview = movie.overview {
            stack.addArrangedSubview(ControlFactory.createLabel("Overview: \(overview)"))
        }
        if let runTime = movie.runtime {
            stack.addArrangedSubview(ControlFactory.createLabel("Runtime: \(runTime)"))
        }
        if let homepage = movie.homepage {
            stack.addArrangedSubview(ControlFactory.createButton(title: homepage, target: self, selector: #selector(goToHomePage)))
        }
    }
}
