//
//  Utils.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 30/03/23.
//

import Foundation
import UIKit

class Utils {
    static func getSkillAttributedString(skills: [String], fontSize: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString("")
        
        let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)]
        let SkillBold = NSAttributedString.init(string: "Skills: ", attributes: boldAttribute)
        
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        
        attributedString.append(SkillBold)
        for i in 0..<skills.count {
            attributedString.append(NSAttributedString(string: skills[i], attributes: attribute))
            if i != skills.count - 1 {
                attributedString.append(NSAttributedString(string: " • ", attributes: attribute))
            }
        }
        
        return  attributedString
    }
}
