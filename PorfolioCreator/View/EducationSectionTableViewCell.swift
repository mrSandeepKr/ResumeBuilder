//
//  EducationSectionTableViewCell.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import UIKit

class EducationSectionTableViewCell: UITableViewCell {
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleTextView)
        contentView.addSubview(subtitleTextView)
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            titleTextView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleTextView.heightAnchor.constraint(equalToConstant: 20),
            titleTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        constraints.append(contentsOf: [
            subtitleTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 5),
            subtitleTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleTextView.heightAnchor.constraint(equalToConstant: 20),
            subtitleTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        return  constraints
    }
}
