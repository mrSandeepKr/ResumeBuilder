//
//  TextChipView.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 04/04/23.
//

import Foundation
import UIKit

protocol SingleChipViewProtocol {
    func removeChip(singleChipModel: SingleChipModel)
}

class SingleChipView: UIView {
    let model: SingleChipModel
    
    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: model.fontSize)
        textLabel.clipsToBounds = true
        textLabel.lineBreakMode = .byClipping
        return textLabel
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.init(systemName: "xmark"), for: .normal)
        button.tintColor = .systemBackground
        return button
    }()
    
    var delegate: SingleChipViewProtocol?
    
    init(model: SingleChipModel) {
        self.model = model
        super.init(frame: .zero)
        
        dismissButton.isHidden = !model.isDismissable
        textLabel.text = model.labelText
        backgroundColor = model.color
        
        addSubview(textLabel)
        addSubview(dismissButton)
        
        dismissButton.addTarget(self, action: #selector(removeChip), for: .touchUpInside)
        layer.cornerRadius = model.cornerRadius
        layer.masksToBounds = true
        
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: model.verticalMargin),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: model.horizontalMargin),
            textLabel.heightAnchor.constraint(equalToConstant: textLabelSize.height),
            textLabel.widthAnchor.constraint(equalToConstant: textLabelSize.width),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -model.verticalMargin)
        ])
        
        if model.isDismissable {
            constraints.append(contentsOf: [
                dismissButton.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: model.buttonMargin),
                dismissButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                dismissButton.heightAnchor.constraint(equalToConstant: buttonSize),
                dismissButton.widthAnchor.constraint(equalTo: dismissButton.heightAnchor),
                dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -model.horizontalMargin)
            ])
        }

        constraints.forEach { constraint in
            if constraint.firstAttribute == .height || constraint.firstAttribute == .leading {
                constraint.priority = .required
            }
        }
        
        return constraints
    }
    
    @objc func removeChip() {
        delegate?.removeChip(model: model)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = textLabelSize.width + (model.isDismissable ? (model.buttonMargin + buttonSize):0 ) + (2*model.horizontalMargin)
        let height = textLabelSize.height + (2*model.verticalMargin)
        return CGSize(width: width, height: height)
    }
    
    var textLabelSize: CGSize {
        return textLabel.sizeThatFits(CGSize(width: 500, height: 100))
    }
    
    var buttonSize: CGFloat {
        return textLabelSize.height * 0.6
    }
}
