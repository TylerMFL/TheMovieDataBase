//
//  UICheckBoxView.swift
//  RedDog
//
//  Created by Marco Antonio Flores Lopez on 15/03/21.
//

import Foundation
import UIKit

protocol UICheckBoxViewDelegate {
    func didChange(checkBoxView: UICheckBoxView, isActive: Bool)
}

class UICheckBoxView: UIStackView {
    
    var delegate: UICheckBoxViewDelegate?
    
    var borderWidth: CGFloat = 1.0 {
        didSet {
            borderView.layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }
    
    var cornerRadius: CGFloat = 1.0 {
        didSet {
            borderView.layer.cornerRadius = cornerRadius
            valueView.layer.cornerRadius = cornerRadius
            setNeedsLayout()
        }
    }
    
    var borderColor: UIColor = UIColor.gray {
        didSet {
            borderView.layer.borderColor = borderColor.cgColor
            setNeedsLayout()
        }
    }
    
    var valueColor: UIColor = UIColor.gray {
        didSet {
            valueView.backgroundColor = valueColor
            valueView.layer.borderColor = valueColor.cgColor
            changeValueColor()
            setNeedsLayout()
        }
    }
    
    private var ratio: CGFloat = 25.0 {
        didSet {
            NSLayoutConstraint.deactivate([
                borderView.widthAnchor.constraint(equalToConstant: ratio),
                borderView.heightAnchor.constraint(equalToConstant: ratio),
            ])
            NSLayoutConstraint.activate([
                borderView.widthAnchor.constraint(equalToConstant: ratio),
                borderView.heightAnchor.constraint(equalToConstant: ratio),
            ])
            setNeedsUpdateConstraints()
            setNeedsLayout()
        }
    }
    
    var isSelected: Bool = false
    
    lazy var contentView: UIView = {
        let contentView = UIView(frame: CGRect.zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var borderView: UIView = {
        let borderView = UIView(frame: CGRect.zero)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = .white
        return borderView
    }()
    
    lazy var valueView: UIView = {
        let valueView = UIView(frame: CGRect.zero)
        valueView.translatesAutoresizingMaskIntoConstraints = false
        return valueView
    }()
    
    lazy var textLabel: UILabel = {
        let textLabel = UILabel(frame: CGRect.zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .natural
        return textLabel
    }()
    
    required init(coder: NSCoder) {
        super.init(frame: CGRect.zero)
    }
    
    init(frame: CGRect, isSelected: Bool) {
        super.init(frame: frame)
        
        self.isSelected = isSelected
        
        translatesAutoresizingMaskIntoConstraints = false
        spacing = 8.0
        axis = .horizontal
        alignment = .fill
        distribution = .fillProportionally
        clipsToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(gesture)
        
        changeValueColor()
    }
    
    override func layoutSubviews() {
        addComponents()
        layoutComponents()
        
        setNeedsLayout()
    }
    
    private func addComponents() {
        addArrangedSubview(contentView)
        contentView.addSubview(borderView)
        borderView.addSubview(valueView)
        addArrangedSubview(textLabel)
    }
    
    private func layoutComponents() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: ratio),
            
            borderView.widthAnchor.constraint(equalToConstant: ratio),
            borderView.heightAnchor.constraint(equalToConstant: ratio),
            borderView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            borderView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            valueView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor),
            valueView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor),
            valueView.widthAnchor.constraint(equalTo: borderView.widthAnchor, multiplier: 0.7),
            valueView.heightAnchor.constraint(equalTo: borderView.heightAnchor, multiplier: 0.7),
            
            textLabel.firstBaselineAnchor.constraint(equalTo: borderView.firstBaselineAnchor),
        ])
    }
    
    private func changeValueColor() {
        valueView.backgroundColor = isSelected ? valueColor : .white
    }
    
    @objc private func didTapView() {
        
        isSelected = !isSelected
        
        changeValueColor()
        
        if let delegate = delegate {
            delegate.didChange(checkBoxView: self, isActive: isSelected)
        }
    }
    
    func setRatio(_ ratio: CGFloat) -> UICheckBoxView {
        self.ratio = ratio
        return self
    }
}
