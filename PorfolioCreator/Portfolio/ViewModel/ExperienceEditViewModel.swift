//
//  ExperienceEditViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 06/04/23.
//

import Foundation

import Foundation

class ExperienceEditViewModel {
    let experienceRepository: ExperienceDataRespository = ExperienceDataRespository()
    var experienceModel: ExperienceModel
    var isCreatingExperience: Bool
    
    init(experienceModel: ExperienceModel = ExperienceModel.defaultInstance, isCreatingExperience: Bool) {
        self.experienceModel = experienceModel
        self.isCreatingExperience = isCreatingExperience
    }
    
    func updateInfo(companyName: String,
                    designation: String,
                    roleDescription: String,
                    startDate: Date,
                    endDate: Date,
                    isPresent: Bool,
                    skills: [String]) async {
        // some validation later
        let newExperience = ExperienceModel(id: isCreatingExperience ? UUID() : experienceModel.id,
                                            companyName: companyName,
                                            designation: designation,
                                            roleDescription: roleDescription,
                                            startDate: startDate,
                                            endDate: endDate,
                                            isPresent: isPresent,
                                            skills: skills)
        
        if isCreatingExperience {
            experienceRepository.create(newExperience)
        }
        else {
            _ = experienceRepository.update(newExperience)
        }
        
    }
}
