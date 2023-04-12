//
//  ExperienceModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 26/03/23.
//


// Delete This

import Foundation

struct ExperienceModel {
    let id: UUID
    let companyName: String
    let designation: String
    let roleDescription: String
    let startDate: Date
    let endDate: Date?
    let isPresent: Bool
    let skills: [String]
    
    init(id: UUID = UUID(), companyName: String, designation: String, roleDescription: String, startDate: Date, endDate: Date?, isPresent: Bool, skills: [String]) {
        self.id = id
        self.companyName = companyName
        self.designation = designation
        self.roleDescription = roleDescription
        self.startDate = startDate
        self.endDate = endDate
        self.isPresent = isPresent
        self.skills = skills
    }
    
    static let defaultInstance = ExperienceModel(companyName: "",
                                                 designation: "",
                                                 roleDescription: "",
                                                 startDate: Date(),
                                                 endDate: nil,
                                                 isPresent: false,
                                                 skills: [])
}
