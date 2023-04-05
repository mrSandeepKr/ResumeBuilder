//
//  SkillsEditViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 04/04/23.
//

import Foundation

class SkillsEditViewModel {
    var skills: [Skill] = [Skill]()
    
    var removethisSkilltest = ["abc", "abcd", "ABCDE", "abcdef", "abcdefg", "abcdefgh", "abcdef ghijklmnop"]
    
    func fetchAndUpdateSkills() async {
        skills =  removethisSkilltest.map({Skill.init(name: $0)})
    }
    
    func removeSkill(skill: Skill) async {
        removethisSkilltest.removeAll(where: {$0 == skill.name})
    }
    
    func addSkill(skillText: String) async {
        removethisSkilltest.append(skillText)
    }
}
