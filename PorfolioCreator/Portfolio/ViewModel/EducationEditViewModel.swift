//
//  EducationEditViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 06/04/23.
//

import Foundation

class EducationEditViewModel {
    var educationModel: EducationModel
    let isEmptyForm: Bool
    let educationRepository: EducationRepository = EducationDataRespository()
    
    init(educationModel: EducationModel, isEmptyForm: Bool) {
        self.educationModel = educationModel
        self.isEmptyForm = isEmptyForm
    }
    
    func updateInfo(institution:String,
                    degree: String,
                    fieldOfStudy: String,
                    startDate: Date,
                    endDate: Date?,
                    isPresent: Bool,
                    grade: String,
                    description: String) async {
        let newEducationModel = EducationModel(id: isEmptyForm ? UUID() : educationModel.id ,
                                               institution: institution,
                                               degree: degree,
                                               fieldOfStudy: fieldOfStudy,
                                               startDate: startDate,
                                               endDate: endDate,
                                               grade: grade,
                                               description: description,
                                               skills: [],
                                               isPresent: isPresent)
        
        if isEmptyForm {
            educationRepository.create(education: newEducationModel)
        }
        else {
            _ = educationRepository.update(newEducationModel)
        }
    }
}
