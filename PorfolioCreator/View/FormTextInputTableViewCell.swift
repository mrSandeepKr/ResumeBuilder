//
//  FormTableViewCell.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 02/04/23.
//

import UIKit

class FormTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let fieldViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(fieldViewContainer)
        
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        let sideMargin: CGFloat = 10
        let titleHeight: CGFloat = 15
        
        constraints.append(contentsOf: [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin),
            titleLabel.heightAnchor.constraint(equalToConstant: titleHeight),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: sideMargin)
        ])
        
        constraints.append(contentsOf: [
            fieldViewContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            fieldViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin),
            fieldViewContainer.heightAnchor.constraint(equalToConstant: 50),
            fieldViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin),
            fieldViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.priority = UILayoutPriority(999)
            }
        }
        
        return constraints
    }
    
    public func configureCell(model: FormCellModel) {
        switch model.formCellType {
        case .date:
            setUpDateField(model: model)
        case .text:
            setUpTextField(model: model)
        }
        
        titleLabel.text = model.cellLabel
    }
}

extension FormTableViewCell {
    private func setUpTextField(model: FormCellModel) {
        guard let model = model as? FormTextInputCellModel else {
            return // throw error
        }
        let countingTextView = UICountingTextView()
        
        fieldViewContainer.addSubview(countingTextView)
        fieldViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.constraintEdges(view: countingTextView,
                                           parentView: fieldViewContainer)
        
        guard let heighConstraint = fieldViewContainer.constraints.first(where: { $0.firstAttribute == .height})
        else {return}
        
        heighConstraint.constant = getTextInputFieldHeight(model: model)
    }
    
    private func setUpDateField(model: FormCellModel) {
        let dateTextView = UIDateTextField()
        fieldViewContainer.addSubview(dateTextView)
        dateTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.constraintEdges(view: dateTextView,
                                           parentView: fieldViewContainer)
        
        guard let heighConstraint = fieldViewContainer.constraints.first(where: { $0.firstAttribute == .height})
        else {return}
        
        heighConstraint.constant = 30
    }
    
    private func getTextInputFieldHeight(model: FormTextInputCellModel) -> CGFloat {
        return CGFloat(50 + (model.maximumNumberOfLines - 1) * 15)
    }
}


