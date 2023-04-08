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
    }
    
    func fetchData() async {
        data[0].content = [aboutDataRepository.getAbout()]
        data[1].content = experienceDataRepository.getAll() ?? []
        data[2].content = educationDataRepository.getAll() ?? []
        data[3].content = [SkillSectionModel(skills: skillDataRepository.getAll() ?? [])]
        print(data)
    }
}
