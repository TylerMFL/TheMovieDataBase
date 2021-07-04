//
//  UIFunctions.swift
//  RedDog
//
//  Created by Marco Antonio Flores Lopez on 18/03/21.
//

import Foundation
import UIKit

class ControlFactory {
    
    class func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }
    
    class func createSimpleView() -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    class func createSimpleStack() -> UIStackView {
        return createSimpleStack(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    class func createSimpleStack(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> UIStackView {
        let stack = UIStackView(frame: CGRect.zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8.0
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.clipsToBounds = true
        return stack
    }
    
    class func createOneLineStackView(image: UIImage, label: UILabel) -> UIStackView {
        let stack = createSimpleStack()
        stack.distribution = .fillProportionally
        
        let stackHorizontal = createSimpleStack()
        stackHorizontal.axis = .horizontal
        stackHorizontal.distribution = .fillProportionally
        stackHorizontal.spacing = 0
        
        let imageView = createImageView(image: image)
        imageView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        label.widthAnchor.constraint(greaterThanOrEqualToConstant: 120.0).isActive = true
        
        stackHorizontal.addArrangedSubview(imageView)
        stackHorizontal.addArrangedSubview(label)
        
        stack.addArrangedSubview(stackHorizontal)
        
        return stack
    }
    
    class func createOneLineStackView(text: String, label: UILabel) -> UIStackView {
        let stack = createSimpleStack(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        
        let stackHorizontal = createSimpleStack()
        stackHorizontal.axis = .horizontal
        stackHorizontal.spacing = 20.0
        stackHorizontal.alignment = .fill
        stackHorizontal.distribution = .fillProportionally
        let labelTitle = createLabel(text)
        labelTitle.font = kStyle.fonts.helveticaBold
        stackHorizontal.addArrangedSubview(labelTitle)
        stackHorizontal.addArrangedSubview(label)
        
        stack.addArrangedSubview(stackHorizontal)
        
        return stack
    }
    
    class func createLabel(_ text: String, _ margin: CGFloat = 0) -> UILabel {
        let label = UIPaddingLabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textEdgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        label.font = kStyle.fonts.helvetica
        label.textColor = kStyle.colors.gray
        label.text = text
        label.numberOfLines = 0
        return label
    }
    
    class func createLabel(_ attributedString: NSAttributedString, _ margin: CGFloat = 0) -> UILabel {
        let label = createLabel("", margin)
        label.attributedText = attributedString
        return label
    }
    
    class func createRadioButton(_ text: String?, isSelected: Bool = false, delegate: UICheckBoxViewDelegate? = nil) -> UICheckBoxView {
        let uiCheckBoxView = UICheckBoxView(frame: CGRect.zero, isSelected: isSelected)
        uiCheckBoxView.translatesAutoresizingMaskIntoConstraints = false
        uiCheckBoxView.borderColor = kStyle.colors.lightGray
        uiCheckBoxView.valueColor = kStyle.colors.gray
        uiCheckBoxView.cornerRadius = 10.0
        uiCheckBoxView.borderWidth = 1.5
        uiCheckBoxView.textLabel.text = text
        uiCheckBoxView.delegate = delegate
        return uiCheckBoxView
    }
    
    class func createSeparatorView() -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = kStyle.colors.lightGray
        view.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        return view
    }
    
    class func createSimpleButton(title: String, target: Any? = nil, selector: Selector? = nil) -> UIButton {
        let button = UIButton(frame: CGRect.zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        guard let target = target, let selector = selector else {
            return button
        }
        button.addTarget(target, action: selector, for: .touchUpInside)
        return button
    }
    
    class func createButton(title: String, target: Any? = nil, selector: Selector? = nil) -> UIButton {
        let button = createSimpleButton(title: title, target: target, selector: selector)
        button.layer.cornerRadius = 5.0
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = kStyle.fonts.helvetica
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        let spaces = CGFloat(title.components(separatedBy: "\n").count)
        button.heightAnchor.constraint(equalToConstant: spaces * 40.0).isActive = true
        return button
    }
    
    class func createButton(attributedString: NSAttributedString, target: Any? = nil, selector: Selector? = nil) -> UIButton {
        let button = createSimpleButton(title: "", target: target, selector: selector)
        button.layer.cornerRadius = 5.0
        button.setTitleColor(kStyle.colors.lightGray, for: .normal)
        button.backgroundColor = kStyle.colors.red
        button.titleLabel?.font = kStyle.fonts.helvetica
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setAttributedTitle(attributedString, for: .normal)
        let spaces = CGFloat(attributedString.string.components(separatedBy: "\n").count)
        button.heightAnchor.constraint(equalToConstant: spaces * 40.0).isActive = true
        return button
    }
    
    class func createImageView(image: UIImage?) -> UIImageView {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }
    
    class func createTableView(dataSource: UITableViewDataSource? = nil, delegate: UITableViewDelegate? = nil) -> UITableView {
        let table = UITableView(frame: CGRect.zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = dataSource
        table.delegate = delegate
        return table
    }
    
    class func createCircularLabel(label: UILabel, size: CGFloat) -> UIView {
        let view = createSimpleView()
        view.layer.cornerRadius = size * 0.5
        
        view.addSubview(label)
        
        label.clipsToBounds = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: size),
            view.widthAnchor.constraint(equalToConstant: size),
            
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        ])
        
        return view
    }
}
