//
//  View.swift
//  RedDog
//
//  Created by Marco Antonio Flores Lopez on 10/03/21.
//

import Foundation
import UIKit
import SwiftSpinner

protocol View {
    func closeSession()
    func showSpinner(title: String)
    func hideSpinner(completion: (()->())?)
    func showAlert(type: UICustomAlertType, message: String?)
    func showAlert(type: UICustomAlertType, message: String?, actions: [customAlertAction]?)
    func showAlert(type: UICustomAlertType, message: String?, actions: [customAlertAction]?, image: UIImage?)
    func showAlert(type: UICustomAlertType, message: String?, actions: [customAlertAction]?, image: UIImage?, actionsDirection: NSLayoutConstraint.Axis)
    func hideAlert()
    func presentVC(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
}

extension View {
    
    func closeSession() { }
    
    func showSpinner(title: String = "") {
        SwiftSpinner.show(title)
    }
    
    func hideSpinner(completion: (()->())? = nil) {
        DispatchQueue.main.async {
            if let completion = completion {
                SwiftSpinner.hide(completion)
            } else {
                SwiftSpinner.hide()
            }
        }
    }
    
    func showAlert(type: UICustomAlertType, message: String?) {
        showAlert(type: type, message: message, actions: nil, image: nil, actionsDirection: .vertical)
    }
    
    func showAlert(type: UICustomAlertType, message: String?, actions: [customAlertAction]?) {
        showAlert(type: type, message: message, actions: actions, image: nil, actionsDirection: .vertical)
    }
    
    func showAlert(type: UICustomAlertType, message: String?, actions: [customAlertAction]?, image: UIImage?) {
        showAlert(type: type, message: message, actions: actions, image: image, actionsDirection: .vertical)
    }
    
    func showAlert(type: UICustomAlertType, message: String?, actions: [customAlertAction]?, image: UIImage?, actionsDirection: NSLayoutConstraint.Axis = .vertical) {
        UICustomAlertViewController.show(type: type, message: message, actions: actions, image: image, actionsDirection: actionsDirection)
    }
    
    func hideAlert() {
        UICustomAlertViewController.hide()
    }
    
    func presentVC(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        if let selfvc = self as? UIViewController {
            selfvc.present(viewControllerToPresent, animated: animated, completion: completion)
        }
    }
}
