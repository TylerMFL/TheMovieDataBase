//
//  UICustomAlertView.swift
//  RedDog
//
//  Created by Marco Antonio Flores Lopez on 26/03/21.
//

import Foundation
import UIKit

struct customAlertAction {
    let title: String
    let handler: (() -> Void)?
}

enum UICustomAlertType {
    case info
    case error
    case question
}

protocol UICustomAlertViewDelegate {
    func didSelectAction(tag: Int)
    func closeAlert()
}

class UICustomAlertView: UIView {

    private var blockedView: UIView = {
        let view = ControlFactory.createSimpleView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.15)
        return view
    }()
    
    private var stack: UIStackView = {
        let stack = ControlFactory.createSimpleStack(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        stack.layer.cornerRadius = 15.0
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 8.0
        return stack
    }()
    
    private var imageView: UIImageView = {
        return ControlFactory.createImageView(image: nil)
    }()
    
    private var lblMessage: UILabel = {
        var lblMessage = ControlFactory.createLabel("")
        lblMessage.font = kStyle.fonts.helveticaBold.withSize(22.0)
        lblMessage.numberOfLines = 0
        lblMessage.textAlignment = .center
        return lblMessage
    }()
    
    private var stackActions: UIStackView = {
        let stackActions = ControlFactory.createSimpleStack()
        stackActions.distribution = .fillProportionally
        return stackActions
    }()
    
    var delegate: UICustomAlertViewDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setLayoutComponents()
    }
    
    private func addComponents() {
        addSubview(blockedView)
        addSubview(stack)
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(lblMessage)
        stack.addArrangedSubview(stackActions)
    }
    
    private func setLayoutComponents() {
        NSLayoutConstraint.activate([
            blockedView.leftAnchor.constraint(equalTo: leftAnchor),
            blockedView.topAnchor.constraint(equalTo: topAnchor),
            blockedView.rightAnchor.constraint(equalTo: rightAnchor),
            blockedView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.9),
            stack.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.9),
            
            lblMessage.heightAnchor.constraint(lessThanOrEqualToConstant: 100.0),
        ])
    }
    
    func configure(type: UICustomAlertType, message: String?, actions: [customAlertAction]?, image: UIImage? = nil, actionsDirection: NSLayoutConstraint.Axis = .vertical) {
        
        switch type {
        case .error:
            stack.backgroundColor = kStyle.colors.red
            lblMessage.textColor = .white
            break
        default:
            stack.backgroundColor = kStyle.colors.gray
            lblMessage.textColor = .white
        }
        
        imageView.isHidden = image == nil ? true : false
        imageView.image = image
        
        lblMessage.text = message
        
        stackActions.axis = actionsDirection
        
        for view in stackActions.arrangedSubviews {
            stackActions.removeArrangedSubview(view)
            NSLayoutConstraint.deactivate(view.constraints)
            view.removeFromSuperview()
        }
        
        func createActionButton(action: customAlertAction, selector: Selector? = nil) -> UIButton {
            let button = ControlFactory.createButton(title: action.title, target: self, selector: selector)
            button.titleLabel?.font = kStyle.fonts.helveticaBold.withSize(30.0)
            button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            button.backgroundColor = .clear
            return button
        }
        
        if let actions = actions {
            for (index, action) in actions.enumerated() {
                let button = createActionButton(action: action, selector: #selector(didSelectAction(_:)))
                button.tag = index
                stackActions.addArrangedSubview(button)
            }
        } else {
            let button = createActionButton(action: customAlertAction(title: "ACEPTAR", handler: nil), selector: #selector(closeAlert))
            stackActions.addArrangedSubview(button)
        }
    }
    
    @objc func didSelectAction(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.didSelectAction(tag: sender.tag)
        }
    }
    
    @objc func closeAlert() {
        if let delegate = delegate {
            delegate.closeAlert()
        }
    }
    
}



class UICustomAlertViewController: UIViewController {
    
    private lazy var ui: UICustomAlertView = {
        let view = UICustomAlertView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    static var shared = UICustomAlertViewController()
    
    fileprivate var actions: [customAlertAction]?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        addComponents()
        setLayoutComponents()
    }
        
    private func addComponents() {
        view.addSubview(ui)
    }
    
    private func setLayoutComponents() {
        NSLayoutConstraint.activate([
            ui.leftAnchor.constraint(equalTo: view.leftAnchor),
            ui.topAnchor.constraint(equalTo: view.topAnchor),
            ui.rightAnchor.constraint(equalTo: view.rightAnchor),
            ui.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    class func show(type: UICustomAlertType, message: String?, actions: [customAlertAction]?, image: UIImage? = nil, actionsDirection: NSLayoutConstraint.Axis = .vertical) {
        
        DispatchQueue.main.async {
            let customAlertViewController = UICustomAlertViewController.shared
            customAlertViewController.actions = actions
            customAlertViewController.ui.configure(type: type, message: message, actions: actions, image: image, actionsDirection: actionsDirection)
                    
            if let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window {
                
                customAlertViewController.view.frame = window.bounds
                window.addSubview(customAlertViewController.view)
                
                customAlertViewController.view.layer.opacity = 0.0
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                    customAlertViewController.view.layer.opacity = 1.0
                })
            }
        }
    }
    
    class func hide() {
        DispatchQueue.main.async {
            let customAlertViewController = UICustomAlertViewController.shared
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                customAlertViewController.view.layer.opacity = 0.0
            }) { (success) in
                if success {
                    customAlertViewController.view.removeFromSuperview()
                }
            }
        }
    }
}

extension UICustomAlertViewController: UICustomAlertViewDelegate {
    
    func didSelectAction(tag: Int) {
        if let actions = actions {
            let action = actions[tag]
            if let handler = action.handler {
                DispatchQueue.main.async {
                    handler()
                }
            }
        }
    }
    
    func closeAlert() {
        UICustomAlertViewController.hide()
    }
}
