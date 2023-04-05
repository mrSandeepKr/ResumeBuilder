//
//  SectionListViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

class SectionListViewModel {
    var data = [SectionListDataModel]()
    
    init() {
        data = SectionType.allCases.map { sectionType in
            SectionListDataModel(sectionType: sectionType,content: [SectionBaseModel]())
        }
        
        data[0].content.append(AboutModel(aboutText: "THis is the about section shit I was talkingabout. I am working with Google and was prior working at Microsoft. It has been a long time working here as am mobile engineer. It has been sometime since I worked at iOS development. Apart from this I have also wroked as an Android Engineer."))
                
        data[1].content.append(ExperienceModel(companyName: "1st company name",
                                               designation: "1st designation ",
                                               roleDescription: "I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style. I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style.",
                                               startDate: Date(),
                                               endDate: Date(),
                                               isPresent: false,
                                               skills: ["Something", "Nothing", "Today"]))
        data[1].content.append(ExperienceModel(companyName: "2nd company name",
                                               designation: "2nd Designation ",
                                               roleDescription: "I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style. I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style.",
                                               startDate: Date(),
                                               endDate: Date(),
                                               isPresent: false,
                                               skills: ["Something", "Nothing", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today"]))
        
        data[2].content.append(contentsOf: [
            EducationModel.init(institution: "DPS Ranchi",
                                degree: "Senior Secondary",
                                fieldOfStudy: "PCM",
                                startDate: Date(),
                                endDate: Date(),
                                grade: "10 CGPA",
                                description: "Did something something here.",
                                skills: ["Something", "Nothing", "Today"])
        ])
        
        data[2].content.append(contentsOf: [
            EducationModel.init(institution: "IIT BHU",
                                degree: "BTech in Electronics Engineering",
                                fieldOfStudy: "PCM",
                                startDate: Date(),
                                endDate: Date(),
                                grade: "10 CGPA",
                                description: "Did something something here.",
                                skills: ["Something", "Nothing", "Today"])
        ])
        
        data[3].content.append(
            SkillModel(skills: ["abc", "abcd", "ABCDE", "abcdef", "abcdefg", "abcdefgh", "abcdef ghijklmnop","abc", "abcd", "ABCDE", "abcdef", "abcdefg", "abcdefgh", "abcdef ghijklmnop"].map({Skill.init(name: $0)})))
    }
    
    func fetchData() {
        // make the data base call
    }
}
