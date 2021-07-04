//
//  SplashView.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//

import Foundation
import UIKit
import Lottie

protocol SplashViewDelegate {
}

class SplashView: UIView {
    
    var delegate: SplashViewDelegate?
    
    lazy var animationView: AnimationView = {
        let animationView = AnimationView(frame: CGRect.zero)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.animation = Animation.named("movieTheatre")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        return animationView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setLayoutComponents()
    }
    
    private func addComponents() {
        addSubview(animationView)
    }
    
    private func setLayoutComponents() {
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 300.0),
            animationView.heightAnchor.constraint(equalToConstant: 300.0),
        ])
    }
}

extension SplashView : SplashUIProtocol {
    
    func startAnimation() {
        animationView.play()
    }
    
    func stopAnimation() {
        animationView.stop()
    }
}
