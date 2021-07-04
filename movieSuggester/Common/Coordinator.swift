//
//  Coordinator.swift
//  RedDog
//
//  Created by Marco Antonio Flores Lopez on 10/03/21.
//

import Foundation
import UIKit

protocol Coordinator {
    
    //Common Variables
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var rootViewController: UIViewController? { get set }
    
    //Common methods
    func start()
    func finish()
}
