//
//  SkillsEditViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 04/04/23.
//

import Foundation

class SkillsEditViewModel {
    var skills = [SkillModel]()
    
    func fetchAndUpdateSkills() async {
        //
    }
    
    func removeSkill(skill: SkillModel) async {
        skills.removeAll(where: {$0.name == skill.name})
    }
    
    func addSkill(skillText: String) async {
        if skills.contains(where: { $0.name == skillText}) {
            return
        }
        
        skills.append(SkillModel(name: skillText))
    }
}
