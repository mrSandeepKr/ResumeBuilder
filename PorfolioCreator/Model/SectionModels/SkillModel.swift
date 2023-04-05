//
//  SkillModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

class Skill {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class SkillModel: SectionBaseModel {
    let skills: [Skill]

    init(skills: [Skill]) {
        self.skills = skills

        super.init(sectionType: .Skills)
    }
}
