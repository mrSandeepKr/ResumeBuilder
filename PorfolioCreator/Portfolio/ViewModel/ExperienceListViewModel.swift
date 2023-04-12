//
//  ExperienceListViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 04/04/23.
//

import Foundation

class ExperienceListViewModel {
    var content: [ExperienceModel] = [ExperienceModel]()
    let experienceRepository: ExperienceRepository = ExperienceDataRespository()
    
    public func fetchData() async {
        content = experienceRepository.getAll() ?? []
    }
}
