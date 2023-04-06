//
//  ExperienceEditViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 06/04/23.
//

import Foundation

import Foundation

class ExperienceEditViewModel {
    var experienceModel: ExperienceModel = ExperienceModel(companyName: "",
                                                           designation: "",
                                                           roleDescription: "",
                                                           startDate: Date(),
                                                           endDate: Date(),
                                                           isPresent: false,
                                                           skills: [])
    
    func getData() async {}
    
    func updateInfo() async {}
}
