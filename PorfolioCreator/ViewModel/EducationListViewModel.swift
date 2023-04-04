//
//  EducationListViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 04/04/23.
//

import Foundation

class EducationListViewModel {
    var content: [EducationModel] = [EducationModel]()
    
    public func fetchData() async {
        content = [
            EducationModel.init(institution: "DPS Ranchi",
                                degree: "Senior Secondary",
                                fieldOfStudy: "PCM",
                                startDate: Date(),
                                endDate: Date(),
                                grade: "10 CGPA",
                                description: "Did something something here.",
                                skills: ["Something", "Nothing", "Today"]),
            EducationModel.init(institution: "DPS Ranchi",
                                degree: "Senior Secondary",
                                fieldOfStudy: "PCM",
                                startDate: Date(),
                                endDate: Date(),
                                grade: "10 CGPA",
                                description: "Did something something here.",
                                skills: ["Something", "Nothing", "Today"]),
            EducationModel.init(institution: "DPS Ranchi",
                                degree: "Senior Secondary",
                                fieldOfStudy: "PCM",
                                startDate: Date(),
                                endDate: Date(),
                                grade: "10 CGPA",
                                description: "Did something something here.",
                                skills: ["Something", "Nothing", "Today"])
        ]
    }
}
