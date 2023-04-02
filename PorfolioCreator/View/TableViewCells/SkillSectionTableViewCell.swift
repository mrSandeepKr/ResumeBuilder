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
        let font: UIFont = UIFont.init(name: "verdana", size: 13) ?? UIFont.systemFont(ofSize: 13)
        let fontHeight: CGFloat = font.lineHeight
        
        let viewRightMargin: CGFloat = 30
        let viewLeftMargin: CGFloat = 15
        
        let textVerticalTopMargin: CGFloat = CGFloat(3)
        let textVerticalBottomMargin: CGFloat = CGFloat(5)
        
        
        let textHorizontalMargin: CGFloat = CGFloat(5)
        
        let chipHorizontalMargin = CGFloat(8)
        let chipVerticalMargin: CGFloat = 5
        let chipHeight: CGFloat = fontHeight + (textVerticalTopMargin + textVerticalBottomMargin)
        
        let cornerRadius: CGFloat = 5
        
        var xPos: CGFloat = viewLeftMargin
        var yPos: CGFloat = 10
        
        
        for skill in skills {
            let textWidth = skill.widthOfString(usingFont: font) * 1.2
            let chipEnding = xPos + textWidth + chipHorizontalMargin + 2*textHorizontalMargin + viewRightMargin
            
            if chipEnding > UIScreen.main.bounds.size.width {
                xPos = viewLeftMargin
                yPos += fontHeight + (2*chipVerticalMargin) + (textVerticalTopMargin + textVerticalBottomMargin)
            }
            
            let chipView = UIView(frame: CGRect(x: xPos,
                                                y: yPos,
                                                width: (2*textHorizontalMargin) + textWidth,
                                                height: chipHeight))
            
            chipView.backgroundColor = .systemGray4
            chipView.layer.cornerRadius = cornerRadius
            
            let label = UILabel(frame: CGRect(x: textHorizontalMargin,
                                              y: textVerticalTopMargin,
                                              width: textWidth,
                                              height: fontHeight + 3))
            
            
            label.textColor = .white
            label.layoutMargins = .zero
            label.textAlignment = .center
            label.lineBreakMode = .byClipping
            label.text = skill
            
            chipView.addSubview(label)
            chipsView.addSubview(chipView)
            
            xPos += chipHorizontalMargin + chipView.frame.width
        }
    }
}
