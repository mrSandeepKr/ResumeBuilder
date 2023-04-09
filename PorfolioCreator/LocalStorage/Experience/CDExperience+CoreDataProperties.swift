//
//  CDExperience+CoreDataProperties.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 07/04/23.
//
//

import Foundation
import CoreData

extension CDExperience {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDExperience> {
        return NSFetchRequest<CDExperience>(entityName: "CDExperience")
    }

    @NSManaged public var companyName: String
    @NSManaged public var designation: String
    @NSManaged public var roleDescription: String
    @NSManaged public var id: UUID
    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date?
    @NSManaged public var isPresent: Bool
    
    func convertToExperience() -> ExperienceModel {
        return ExperienceModel(id: self.id,
                               companyName: self.companyName,
                               designation: self.designation,
                               roleDescription: self.roleDescription,
                               startDate: self.startDate,
                               endDate: self.endDate,
                               isPresent: self.isPresent,
                               skills: [])
    }
    
    func update(with experience: ExperienceModel) {
        self.id = experience.id
        self.companyName = experience.companyName
        self.designation = experience.designation
        self.roleDescription = experience.roleDescription
        self.startDate = experience.startDate
        self.endDate = experience.endDate
        self.isPresent = experience.isPresent
    }
}
