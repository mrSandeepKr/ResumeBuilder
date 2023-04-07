//
//  ExperienceEditViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 06/04/23.
//

import Foundation

import Foundation

class ExperienceEditViewModel {
    var experienceModel: ExperienceModel
    
    init(experienceModel: ExperienceModel = ExperienceModel.defaultInstance) {
        self.experienceModel = experienceModel
    }
    
    func getData() async {}
    
    func updateInfo() async {}
}
