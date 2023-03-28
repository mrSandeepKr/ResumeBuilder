//
//  ExperienceModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 26/03/23.
//


// Delete This

import Foundation

public class ExperienceModel: SectionBaseModel {
    let companyName: String
    let designation: String
    let roleDescription: String
    let startDate: Date
    let endDate: Date
    let isPresent: Bool
    
    init(companyName: String, designation: String, roleDescription: String, startDate: Date, endDate: Date, isPresent: Bool) {
        self.companyName = companyName
        self.designation = designation
        self.roleDescription = roleDescription
        self.startDate = startDate
        self.endDate = endDate
        self.isPresent = isPresent
        
        super.init(sectionType: .Experience)
    }
    
    public static func getDefaultValue() -> ExperienceModel {
        return ExperienceModel(companyName: "", designation: "", roleDescription: "", startDate: Date(), endDate: Date(), isPresent: false)
    }
}
