//
//  SkillSectionTableViewCell.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import UIKit

class SkillSectionTableViewCell: UITableViewCell {
    let chipsView: ChipsView = {
        let view = ChipsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(chipsView)
        NSLayoutConstraint.constraintEdges(view: chipsView, parentView: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: SkillModel) {
        chipsView.buildChipView(model: ChipsModel.init(singleChipModels: model.skills.map({getChipModel(skill: $0)}), viewRightMargin: 10))
        
        let heightAnchor = contentView.constraints.first(where: { $0.firstAttribute == .height}) ?? contentView.heightAnchor.constraint(equalToConstant: chipsView.getApproxHeight())
        heightAnchor.constant = chipsView.getApproxHeight()
        heightAnchor.priority = UILayoutPriority(999)
        heightAnchor.isActive = true
    }
    
    func getChipModel(skill: Skill) -> SingleChipModel {
        return SingleChipModel(skill: skill,
                                 isDismissable: false,
                                 color: .gray,
                                 horizontalMargin: 5,
                                 verticalMargin: 5,
                                 cornerRadius: 5,
                                 fontSize: 13)
    }
}
