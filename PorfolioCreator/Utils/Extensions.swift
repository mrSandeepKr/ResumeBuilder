//
//  Extensions.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 26/03/23.
//

import Foundation
import UIKit

extension UITableViewCell {
    static public var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        
        return size.width
    }
}

extension NSLayoutConstraint {
    static func constraintEdges(view: UIView, toLayoutGuide layoutGuide: UILayoutGuide, leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: leading),
            view.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: top),
            view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -trailing),
            view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -bottom)
        ])
    }
    
    static func constraintEdges(view: UIView, parentView layoutView: UIView, leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: layoutView.leadingAnchor, constant: leading),
            view.topAnchor.constraint(equalTo: layoutView.topAnchor, constant: top),
            view.trailingAnchor.constraint(equalTo: layoutView.trailingAnchor, constant: -trailing),
            view.bottomAnchor.constraint(equalTo: layoutView.bottomAnchor, constant: -bottom)
        ])
    }
}

