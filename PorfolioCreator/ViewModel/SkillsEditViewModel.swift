//
//  SkillsEditViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 04/04/23.
//

import Foundation

class SkillsEditViewModel {
    let skillRepository: SkillDataRepository = SkillDataRepository()
    var skills = [SkillModel]()
    
    func fetchAndUpdateSkills() async {
        guard let skills = skillRepository.getAll() else {return}
        self.skills = skills
    }
    
    func removeSkill(skill: SkillModel) async {
        _ = skillRepository.delete(UUID())
    }
    
    func addSkill(skillText: String) async {
        skillRepository.create(skill: SkillModel.init(name: skillText))
    }
}
