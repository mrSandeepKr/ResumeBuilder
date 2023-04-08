//
//  EducationListViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 04/04/23.
//

import Foundation

class EducationListViewModel {
    var content: [EducationModel] = [EducationModel]()
    let educationRepository: EducationRepository = EducationDataRespository()
    
    public func fetchData() async {
        content = educationRepository.getAll() ?? []
    }
}
