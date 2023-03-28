//
//  EducationModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

class EducationModel {
    let school: String
    let Degree: String
    let FieldOfStudy: String
    let startDate: String
    let endDate: String
    let Grade: String
    let description: String
    let skills: [String]
    
    init(school: String, Degree: String, FieldOfStudy: String, startDate: String, endDate: String, Grade: String, description: String, skills: [String]) {
        self.school = school
        self.Degree = Degree
        self.FieldOfStudy = FieldOfStudy
        self.startDate = startDate
        self.endDate = endDate
        self.Grade = Grade
        self.description = description
        self.skills = skills
    }
}
