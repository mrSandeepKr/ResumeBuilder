//
//  ExperienceTableViewCell.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import UIKit

class ExperienceSectionTableViewCell: UITableViewCell {
    let jobLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    let designationTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.boldSystemFont(ofSize: 19)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    
    let jobTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .gray
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    
    let employmentTimeTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .gray
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    
    let roleDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.textContainer.maximumNumberOfLines = 3
        textView.textContainerInset = .zero
        
        textView.isEditable = false
        return textView
    }()
    
    let skillsTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.textContainer.maximumNumberOfLines = 2
        textView.isEditable = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(jobLogoImageView)
        contentView.addSubview(designationTextView)
        contentView.addSubview(jobTextView)
        contentView.addSubview(employmentTimeTextView)
        contentView.addSubview(roleDescriptionTextView)
        contentView.addSubview(skillsTextView)
        
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
       
        let sideMargin = CGFloat(10)
        let topMargin = CGFloat(5)
        let imageSize = CGFloat(55)
        
        let designationHeight = CGFloat(30)
        let baseHeight = CGFloat(20)
        let roleDescHeight = CGFloat(45)
        let skillsHeight = CGFloat(40)
        
        constraints.append(contentsOf: [
            jobLogoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            jobLogoImageView.heightAnchor.constraint(equalToConstant: imageSize),
            jobLogoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin),
            jobLogoImageView.widthAnchor.constraint(equalToConstant: imageSize),
        ])
        
        constraints.append(contentsOf: [
            designationTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topMargin),
            designationTextView.leadingAnchor.constraint(equalTo: jobLogoImageView.trailingAnchor, constant: sideMargin),
            designationTextView.heightAnchor.constraint(equalToConstant: designationHeight),
            designationTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        constraints.append(contentsOf: [
            jobTextView.topAnchor.constraint(equalTo: designationTextView.bottomAnchor, constant: 1),
            jobTextView.leadingAnchor.constraint(equalTo: jobLogoImageView.trailingAnchor, constant: sideMargin),
            jobTextView.heightAnchor.constraint(equalToConstant: baseHeight),
            jobTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        constraints.append(contentsOf: [
            employmentTimeTextView.topAnchor.constraint(equalTo: jobTextView.bottomAnchor, constant: 1),
            employmentTimeTextView.leadingAnchor.constraint(equalTo: jobLogoImageView.trailingAnchor, constant: sideMargin),
            employmentTimeTextView.heightAnchor.constraint(equalToConstant: baseHeight),
            employmentTimeTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        constraints.append(contentsOf: [
            roleDescriptionTextView.topAnchor.constraint(equalTo: employmentTimeTextView.bottomAnchor, constant: 10),
            roleDescriptionTextView.leadingAnchor.constraint(equalTo: jobLogoImageView.trailingAnchor, constant: sideMargin),
            roleDescriptionTextView.heightAnchor.constraint(equalToConstant: roleDescHeight),
            roleDescriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        constraints.append(contentsOf: [
            skillsTextView.topAnchor.constraint(equalTo: roleDescriptionTextView.bottomAnchor, constant: 3),
            skillsTextView.leadingAnchor.constraint(equalTo: jobLogoImageView.trailingAnchor, constant: sideMargin),
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
    
    public func configureCell(model: ExperienceModel) {
        designationTextView.text = model.companyName
        jobTextView.text = model.designation
        employmentTimeTextView.text = "\(dateFormatter.string(from: model.startDate))"
        roleDescriptionTextView.text = model.roleDescription
        skillsTextView.text = "Skills ".appending(model.skills.joined(separator: " • "))
    }
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter
    }
}
