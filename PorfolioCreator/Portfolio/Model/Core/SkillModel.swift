//
//  SkillModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 05/04/23.
//

import Foundation

struct SkillModel {
    let id: UUID
    let name: String
    
    init(id: UUID = UUID(),name: String) {
        self.id = id
        self.name = name
    }
}
