//
//  EducationRepository.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 08/04/23.
//

import CoreData

protocol EducationRepository {
    func create(education: EducationModel)
    func getAll() -> [EducationModel]?
    func get(byIdentifier id: UUID) -> EducationModel?
    func update(_ education: EducationModel) -> Bool
    func delete(_ id: UUID) -> Bool
}

struct EducationDataRespository: EducationRepository {
    func create(education: EducationModel) {
        let cdEducation = CDEducation(context: PersistentStorage.shared.context)
        cdEducation.update(with: education)
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [EducationModel]? {
        do {
            guard let educations = try PersistentStorage.shared.context.fetch(CDEducation.fetchRequest()) as? [CDEducation]
            else {
                return nil
            }
            return educations.map({$0.convertToEducation()})
        }
        catch {
            debugPrint(error)
            return nil
        }
    }
    
    func get(byIdentifier id: UUID) -> EducationModel? {
        guard let education = getEducation(byIdentifier: id) else {
            return nil
        }
        return education.convertToEducation()
    }
    
    func update(_ education: EducationModel) -> Bool {
        guard let cdEducation = getEducation(byIdentifier: education.id) else {
            return  false
        }
        cdEducation.update(with: education)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(_ id: UUID) -> Bool {
        guard let cdEmployee = getEducation(byIdentifier: id) else {
            return false
        }
        
        PersistentStorage.shared.context.delete(cdEmployee)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    private func getEducation(byIdentifier id: UUID) -> CDEducation? {
        let fetchRequest = NSFetchRequest<CDEducation>(entityName: "CDEducation")
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
