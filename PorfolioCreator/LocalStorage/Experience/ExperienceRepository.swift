//
//  ExperienceRepository.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 07/04/23.
//

import CoreData

protocol ExperienceRepository {
    func create(_ experience: ExperienceModel)
    func getAll() -> [ExperienceModel]?
    func get(byIdentifier id: UUID) -> ExperienceModel?
    func update(_ experience: ExperienceModel) -> Bool
    func delete(_ id: UUID) -> Bool
}

struct ExperienceDataRespository: ExperienceRepository {
    func create(_ experience: ExperienceModel) {
        let cdExperience = CDExperience(context: PersistentStorage.shared.context)
        
        cdExperience.update(with: experience)
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [ExperienceModel]? {
        do {
            guard let experiences = try PersistentStorage.shared.context.fetch(CDExperience.fetchRequest()) as? [CDExperience]
            else {
                return nil
            }
            return experiences.map({$0.convertToExperience()})
        }
        catch {
            debugPrint(error)
            return nil
        }
    }
    
    func get(byIdentifier id: UUID) -> ExperienceModel? {
        guard let experience = getExperience(byIdentifier: id) else {
            return nil
        }
        return experience.convertToExperience()
    }
    
    func update(_ experience: ExperienceModel) -> Bool {
        guard let cdExperience = getExperience(byIdentifier: experience.id)
        else {return false}
        
        cdExperience.update(with: experience)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(_ id: UUID) -> Bool {
        guard let cdExperience = getExperience(byIdentifier: id) else {
            return false
        }
        
        PersistentStorage.shared.context.delete(cdExperience)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    private func getExperience(byIdentifier id: UUID) -> CDExperience? {
        let fetchRequest = NSFetchRequest<CDExperience>(entityName: "CDExperience")
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
