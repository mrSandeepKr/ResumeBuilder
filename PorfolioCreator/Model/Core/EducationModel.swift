//
//  EducationModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

class EducationModel {
    let institution: String
    let degree: String
    let fieldOfStudy: String
    let startDate: Date
    let endDate: Date
    let grade: String
    let description: String
    let skills: [String]
    let isPresent: Bool
    
    init(institution: String, degree: String, fieldOfStudy: String, startDate: Date, endDate: Date, grade: String, description: String, skills: [String], isPresent: Bool) {
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
}
