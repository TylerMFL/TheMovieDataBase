//
//  MoviePoolTableViewCell.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 02/07/21.
//

import Foundation
import UIKit
import Kingfisher

class MoviePoolTableViewCell: UITableViewCell, TmdbTableViewCellProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var heigth: CGFloat = 250
    
    private lazy var hStack: UIStackView = {
        let hStack = ControlFactory.createSimpleStack(top: 8, left: 20, bottom: 8, right: 20)
        hStack.axis = .horizontal
        hStack.distribution = .fillProportionally
        hStack.spacing = 20
        hStack.addArrangedSubview(imgPosterImage)
        let vStack = ControlFactory.createSimpleStack()
        hStack.addArrangedSubview(vStack)
        vStack.addArrangedSubview(lbTitle)
        vStack.addArrangedSubview(lbGenre)
        let hStack2 = ControlFactory.createSimpleStack(top: 8, left: 8, bottom: 8, right: 8)
        hStack2.axis = .horizontal
        vStack.addArrangedSubview(hStack2)
        hStack2.addArrangedSubview(lbPopularity)
        hStack2.addArrangedSubview(lbReleaseDate)
        return hStack
    }()
    
    private lazy var imgPosterImage: UIImageView = {
        let imgPosterImage = ControlFactory.createImageView(image: nil)
        imgPosterImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return imgPosterImage
    }()
    
    private lazy var lbTitle: UILabel = {
        let lbTitle = ControlFactory.createLabel("")
        lbTitle.font = kStyle.fonts.helveticaBold.withSize(24)
        return lbTitle
    }()
    
    private lazy var lbGenre: UILabel = {
        let lbGenre = ControlFactory.createLabel("")
        lbGenre.font = kStyle.fonts.helvetica.withSize(18)
        return lbGenre
    }()
    
    private lazy var lbPopularity: UILabel = {
        let lbPopularity = ControlFactory.createLabel("")
        lbPopularity.font = kStyle.fonts.helvetica.withSize(12)
        return lbPopularity
    }()
    
    private lazy var lbReleaseDate: UILabel = {
        let lbReleaseDate = ControlFactory.createLabel("")
        lbReleaseDate.font = kStyle.fonts.helvetica.withSize(12)
        return lbReleaseDate
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addComponents()
        setLayoutComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        contentView.addSubview(hStack)
    }
    
    private func setLayoutComponents() {
        NSLayoutConstraint.activate([
            hStack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            hStack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hStack.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    func configure<Model>(model: Model) {
        
        lbTitle.text = ""
        lbGenre.text = ""
        lbPopularity.text = ""
        lbReleaseDate.text = ""
        imgPosterImage.image = nil
        
        if let model = model as? (repository: TmdbRepository, config: Config, shortMovie: ShortMovie) {
            
            lbTitle.text = model.shortMovie.title
            if let genres = model.shortMovie.genres {
                for (i, g) in genres.enumerated() {
                    lbGenre.text?.append("\(g)\(i < genres.count ? " - " : " ")")
                }
            }
            
            if let popularity = model.shortMovie.popularity {
                lbPopularity.text = "Popularity: \(popularity)"
            }
            
            if let releaseDate = model.shortMovie.releaseDate {
                lbReleaseDate.text = "Release date: \(releaseDate)"
            }
            
            if let url = model.repository.getPosterUrl(name: model.shortMovie.posterPath ?? "", size: model.config.images?.posterSizes?.first ?? "w500") {
                imgPosterImage.kf.setImage(with: url)
            }
        }
    }
}
