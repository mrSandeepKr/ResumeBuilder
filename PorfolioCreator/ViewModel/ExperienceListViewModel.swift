//
//  ExperienceListViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 04/04/23.
//

import Foundation

class ExperienceListViewModel {
    var content: [ExperienceModel] = [ExperienceModel]()
    
    public func fetchData() async {
        content = [
            ExperienceModel(companyName: "1st company name",
                           designation: "1st designation ",
                           roleDescription: "I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style. I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style.",
                           startDate: Date(),
                           endDate: Date(),
                           isPresent: false,
                           skills: ["Something", "Nothing", "Today"]),
            ExperienceModel(companyName: "2nd company name",
                           designation: "2nd Designation ",
                           roleDescription: "I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style. I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style.",
                           startDate: Date(),
                           endDate: Date(),
                           isPresent: false,
                           skills: ["Something", "Nothing", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today"]),
            ExperienceModel(companyName: "2nd company name",
                        designation: "2nd Designation ",
                        roleDescription: "I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style. I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style.",
                        startDate: Date(),
                        endDate: Date(),
                        isPresent: false,
                        skills: ["Something", "Nothing", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today"])
        ]
    }
}
