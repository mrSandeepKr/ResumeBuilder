//
//  EducationModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

struct EducationModel {
    let id: UUID
    let institution: String
    let degree: String
    let fieldOfStudy: String
    let startDate: Date
    let endDate: Date?
    let grade: String
    let description: String
    let skills: [String]
    let isPresent: Bool
    
    init(id: UUID = UUID(),
         institution: String,
         degree: String,
         fieldOfStudy: String,
         startDate: Date,
         endDate: Date?,
         grade: String,
         description: String,
         skills: [String],
         isPresent: Bool) {
        self.id = id
        self.institution = institution
        self.degree = degree
        self.fieldOfStudy = fieldOfStudy
        self.startDate = startDate
        self.endDate = endDate
        self.grade = grade
        self.description = description
        self.skills = skills
        self.isPresent = isPresent
    }
    
    static let defaultInstance = EducationModel(institution: "",
                                                degree: "",
                                                fieldOfStudy: "",
                                                startDate: Date(),
                                                endDate: Date(),
                                                grade: "",
                                                description: "",
                                                skills: [],
                                                isPresent: false)
}
