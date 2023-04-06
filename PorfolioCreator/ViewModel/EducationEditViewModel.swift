//
//  EducationEditViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 06/04/23.
//

import Foundation

class EducationEditViewModel {
    var educationModel: EducationModel = EducationModel(institution: "",
                                                        degree: "",
                                                        fieldOfStudy: "",
                                                        startDate: Date(),
                                                        endDate: Date(),
                                                        grade: "",
                                                        description: "",
                                                        skills: [],
                                                        isPresent: false)
    
    func getData() async {}
    
    func updateInfo() async {}
}
