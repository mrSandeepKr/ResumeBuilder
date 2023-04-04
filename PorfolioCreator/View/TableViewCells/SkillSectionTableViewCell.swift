//
//  SkillSectionTableViewCell.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import UIKit

class SkillSectionTableViewCell: UITableViewCell {
    let chipsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(chipsView)
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        let heightAnchor = chipsView.heightAnchor.constraint(equalToConstant: 300)
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
    
    func configureCell(model: SkillModel) {
        chipsView.subviews.forEach({ $0.removeFromSuperview() })
        
        buildCloudView(skills: model.skills)
    }
    
    func buildCloudView(skills:[String]) {
        let viewRightMargin: CGFloat = 30
        let viewLeftMargin: CGFloat = 15
        
        let chipHorizontalMargin = CGFloat(8)
        let chipVerticalMargin: CGFloat = 5
        
        var xPos: CGFloat = viewLeftMargin
        var yPos: CGFloat = 10
        
        
        for skill in skills {
            let chipView = SingleChipView(model: getChipModel(skill: skill))
            let sz = chipView.sizeThatFits(CGSize.init(width: 1000, height: 200))
            
            if xPos + sz.width + chipHorizontalMargin + viewRightMargin > UIScreen.main.bounds.width {
                xPos = viewLeftMargin
                yPos += sz.height + (2*chipVerticalMargin)
            }
            
            chipView.frame = CGRect(origin: CGPoint.init(x: xPos, y: yPos), size: sz)
            
            chipsView.addSubview(chipView)
            
            xPos += chipHorizontalMargin + chipView.frame.width
        }
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
