//
//  SceneDelegate.swift
//  movieSuggester
//
//  Created by Marco Antonio Flores Lopez on 29/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let apiKey = Bundle.main.infoDictionary?["ApiKey"] as? String
        let baseUrl = Bundle.main.infoDictionary?["BaseUrl"] as? String
        let imagesUrl = Bundle.main.infoDictionary?["ImagesUrl"] as? String
        
        let dependacyContainer = DependancyContainer(apiKey: apiKey ?? "", baseUrl: baseUrl ?? "", imagesUrl: imagesUrl ?? "")
        let mainCoordinator = MainCoordinator(factory: dependacyContainer)
        mainCoordinator.start()
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = mainCoordinator.navigationController
        window?.backgroundColor = kStyle.colors.marineBlue
        window?.makeKeyAndVisible()
    }
}

