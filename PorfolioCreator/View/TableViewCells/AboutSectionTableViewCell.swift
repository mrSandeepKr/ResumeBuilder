//
//  AboutSectionTableViewCell.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import UIKit

class AboutSectionTableViewCell: UITableViewCell {
    let aboutTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(aboutTextView)
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        let sideMargin = CGFloat(10)
        
        constraints.append(contentsOf: [
            aboutTextView.topAnchor.constraint(equalTo: contentView.topAnchor),
            aboutTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin),
            aboutTextView.heightAnchor.constraint(equalToConstant: 100),
            aboutTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            aboutTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.priority = UILayoutPriority(999)
            }
        }
        
        return constraints
    }
    
    public func configureCell(model: AboutModel) {
        aboutTextView.text = model.aboutText
    }
}
