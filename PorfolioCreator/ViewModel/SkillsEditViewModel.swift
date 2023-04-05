//
//  SkillsEditViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 04/04/23.
//

import Foundation

class SkillsEditViewModel {
    var skills: [SkillModel] = [SkillModel]()
    
    var removethisSkilltest = ["abc", "abcd", "ABCDE", "abcdef", "abcdefg", "abcdefgh", "abcdef ghijklmnop"]
    
    func fetchAndUpdateSkills() async {
        skills =  removethisSkilltest.map({SkillModel.init(name: $0)})
    }
    
    func removeSkill(skill: SkillModel) async {
        removethisSkilltest.removeAll(where: {$0 == skill.name})
    }
    
    func addSkill(skillText: String) async {
        removethisSkilltest.append(skillText)
    }
}
