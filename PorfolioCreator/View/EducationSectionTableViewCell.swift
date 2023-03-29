//
//  EducationSectionTableViewCell.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import UIKit

class EducationSectionTableViewCell: UITableViewCell {
    let educationImageiew: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .cyan
        return imageView
    }()
    
    let institutionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.font = UIFont.boldSystemFont(ofSize: 19)
        return textView
    }()
    
    let degreeTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let skillsTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        //textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(educationImageiew)
        contentView.addSubview(institutionTextView)
        contentView.addSubview(degreeTextView)
        contentView.addSubview(skillsTextView)
        
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        let imageViewSize = CGFloat(55)
        let imageViewTopMargin = CGFloat(15)
        let topMargin = CGFloat(5)
        let sideMargin = CGFloat(10)
        
        let baseHeight = CGFloat(20)
        let institutionTextViewHeight = CGFloat(30)
        let skillsHeight = CGFloat(40)
        
        constraints.append(contentsOf: [
            educationImageiew.topAnchor.constraint(equalTo: contentView.topAnchor, constant: imageViewTopMargin),
            educationImageiew.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin),
            educationImageiew.heightAnchor.constraint(equalToConstant: imageViewSize),
            educationImageiew.widthAnchor.constraint(equalToConstant: imageViewSize)
        ])
        
        constraints.append(contentsOf: [
            institutionTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topMargin),
            institutionTextView.leadingAnchor.constraint(equalTo: educationImageiew.trailingAnchor, constant: sideMargin),
            institutionTextView.heightAnchor.constraint(equalToConstant: institutionTextViewHeight),
            institutionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        constraints.append(contentsOf: [
            degreeTextView.topAnchor.constraint(equalTo: institutionTextView.bottomAnchor, constant: 1),
            degreeTextView.leadingAnchor.constraint(equalTo: educationImageiew.trailingAnchor, constant: sideMargin),
            degreeTextView.heightAnchor.constraint(equalToConstant: baseHeight ),
            degreeTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        
        constraints.append(contentsOf: [
            skillsTextView.topAnchor.constraint(equalTo: degreeTextView.bottomAnchor, constant: topMargin),
            skillsTextView.leadingAnchor.constraint(equalTo: degreeTextView.leadingAnchor),
            skillsTextView.heightAnchor.constraint(equalToConstant: skillsHeight),
            skillsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            skillsTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -topMargin)
        ])
        
        constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.priority = UILayoutPriority(999)
            }
        }
        
        return  constraints
    }
    
    public func configureCell(model: EducationModel) {
        self.institutionTextView.text = model.institution
        self.degreeTextView.text = model.degree
        self.skillsTextView.text = model.skills.joined(separator: " • ")
    }
}
