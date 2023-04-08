//
//  CDSkill+CoreDataProperties.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 08/04/23.
//
//

import Foundation
import CoreData

extension CDSkill {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSkill> {
        return NSFetchRequest<CDSkill>(entityName: "CDSkill")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    
    func convertToSkill() -> SkillModel {
        return SkillModel(id: self.id, name: self.name)
    }
}

