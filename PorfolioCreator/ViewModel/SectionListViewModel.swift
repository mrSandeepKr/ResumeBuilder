//
//  SectionListViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

class SectionListViewModel {
    var data = [SectionBaseModel]()
    let aboutDataRepository: AboutRepository = AboutDataRepository()
    let skillDataRepository: SkillRepository = SkillDataRepository()
    let experienceDataRepository: ExperienceRepository = ExperienceDataRespository()
    let educationDataRepository: EducationRepository = EducationDataRespository()
    
    init() {
        data = SectionType.allCases.map { sectionType in
            SectionBaseModel(sectionType: sectionType,content: [AnyObject]())
        }
       // fetchData()
                
//        data[1].content.append(ExperienceModel(companyName: "1st company name",
//                                               designation: "1st designation ",
//                                               roleDescription: "I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style. I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style.",
//                                               startDate: Date(),
//                                               endDate: Date(),
//                                               isPresent: false,
//                                               skills: ["Something", "Nothing", "Today"]))
//        data[1].content.append(ExperienceModel(companyName: "2nd company name",
//                                               designation: "2nd Designation ",
//                                               roleDescription: "I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style. I worked as a mobile engineer building big reliable systems to help incorporate stuff into my day to day life style.",
//                                               startDate: Date(),
//                                               endDate: Date(),
//                                               isPresent: false,
//                                               skills: ["Something", "Nothing", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today", "Today"]))
//
//        data[2].content.append(contentsOf: [
//            EducationModel.init(institution: "DPS Ranchi",
//                                degree: "Senior Secondary",
//                                fieldOfStudy: "PCM",
//                                startDate: Date(),
//                                endDate: Date(),
//                                grade: "10 CGPA",
//                                description: "Did something something here.",
//                                skills: ["Something", "Nothing", "Today"],
//                                isPresent: false)
//        ])
//
//        data[2].content.append(contentsOf: [
//            EducationModel.init(institution: "IIT BHU",
//                                degree: "BTech in Electronics Engineering",
//                                fieldOfStudy: "PCM",
//                                startDate: Date(),
//                                endDate: Date(),
//                                grade: "10 CGPA",
//                                description: "Did something something here.",
//                                skills: ["Something", "Nothing", "Today"],
//                                isPresent: false)
//        ])
//
//        data[3].content.append(
//            SkillSectionModel(skills: skillDataRepository.getAll() ?? []))
    }
    
    func fetchData() async {
        data[0].content = [AboutModel(aboutText: aboutDataRepository.getAboutString())]
        data[1].content = experienceDataRepository.getAll() ?? []
        data[2].content = educationDataRepository.getAll() ?? []
        data[3].content = [SkillSectionModel(skills: skillDataRepository.getAll() ?? [])]
        print(data)
    }
}

