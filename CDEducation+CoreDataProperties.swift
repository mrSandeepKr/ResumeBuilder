//
//  CDEducation+CoreDataProperties.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 08/04/23.
//
//

import Foundation
import CoreData

extension CDEducation {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEducation> {
        return NSFetchRequest<CDEducation>(entityName: "CDEducation")
    }
    
    @NSManaged public var institute: String
    @NSManaged public var degree: String
    @NSManaged public var fieldOfStudy: String
    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date?
    @NSManaged public var learningDescription: String
    @NSManaged public var isPresent: Bool
    @NSManaged public var grade: String
    @NSManaged public var id: UUID
    
    func convertToEducation() -> EducationModel {
        return EducationModel(id: self.id,
                              institution: self.institute,
                              degree: self.degree,
                              fieldOfStudy: self.fieldOfStudy,
                              startDate: self.startDate,
                              endDate: self.endDate,
                              grade: self.grade,
                              description: self.learningDescription,
                              skills: [],
                              isPresent: self.isPresent)
    }
    
    func update(with education: EducationModel) {
        self.id = education.id
        self.fieldOfStudy = education.fieldOfStudy
        self.institute = education.institution
        self.learningDescription = education.description
        self.degree = education.degree
        self.startDate = education.startDate
        self.endDate = education.endDate
        self.isPresent = education.isPresent
        self.grade = education.grade
    }
}
