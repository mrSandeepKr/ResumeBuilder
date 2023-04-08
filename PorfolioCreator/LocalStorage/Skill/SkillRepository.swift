//
//  SkillRepository.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 08/04/23.
//

import Foundation
import CoreData

protocol SkillRepository {
    func create(skill: SkillModel)
    func getAll() -> [SkillModel]?
    //func get(byIdentifier id: UUID) -> SkillModel?
    func delete(_ id: UUID) -> Bool
}

class SkillDataRepository: SkillRepository {
    func create(skill: SkillModel) {
        let cdSkill = CDSkill(context: PersistentStorage.shared.context)
        
        cdSkill.name = skill.name
        cdSkill.id = skill.id
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [SkillModel]? {
        do {
            guard let cdSkills = try PersistentStorage.shared.context.fetch(CDSkill.fetchRequest()) as? [CDSkill]
            else {
                return nil
            }
            
            return cdSkills.map({$0.convertToSkill()})
        }
        catch {
            return nil
        }
    }
    
    func delete(_ id: UUID) -> Bool {
        guard let cdSkill = getSkill(byIdentifier: id) else {
            return false
        }
        
        PersistentStorage.shared.context.delete(cdSkill)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    private func getSkill(byIdentifier id: UUID) -> CDSkill? {
        let fetchRequest = NSFetchRequest<CDSkill>(entityName: "CDSkill")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            return result
            
        } catch let error {
            debugPrint(error)
        }
        
        return nil
    }
}
