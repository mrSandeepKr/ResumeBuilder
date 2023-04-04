//
//  SkillSectionTableViewCell.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import UIKit

class SkillSectionTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: SkillModel) {
        subviews.forEach({$0.removeFromSuperview()})
        
        let chipsView = ChipsView(model: ChipsModel.init(singleChipModels: model.skills.map({getChipModel(skill: $0)})))
        chipsView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(chipsView)
        NSLayoutConstraint.activate(getStaticConstraints(heightConstant: chipsView.getApproxHeight(), chipsView: chipsView))
    }
    
    func getStaticConstraints(heightConstant: CGFloat, chipsView: ChipsView) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        let heightAnchor = chipsView.heightAnchor.constraint(equalToConstant: heightConstant)
        heightAnchor.priority = UILayoutPriority(999)
        constraints.append(contentsOf: [
            chipsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            chipsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            heightAnchor,
            chipsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chipsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        return  constraints
    }
    
    func getChipModel(skill: String) -> SingleChipModel {
        return SingleChipModel(labelText: skill,
                                 isDismissable: true,
                                 color: .gray,
                                 horizontalMargin: 5,
                                 verticalMargin: 5,
                                 cornerRadius: 5,
                                 fontSize: 13)
    }
}
