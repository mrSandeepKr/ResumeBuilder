//
//  SkillModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

class SkillModel: SectionBaseModel {
    let skills: [String]
    
    init(skills: [String]) {
        self.skills = skills
        
        super.init(sectionType: .Skills)
    }
}
