//
//  ClassicResumeFormat.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 15/04/23.
//

import UIKit

class ClassicResumeFormat {
    var data = [SectionType:Any]()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter
    }()
    
    let aboutDataRepository: AboutRepository = AboutDataRepository()
    let skillDataRepository: SkillRepository = SkillDataRepository()
    let experienceDataRepository: ExperienceRepository = ExperienceDataRespository()
    let educationDataRepository: EducationRepository = EducationDataRespository()
    
    func fetchModel() async -> PdfModel {
        data[.About] = aboutDataRepository.getAbout()
        data[.Experience] = experienceDataRepository.getAll() ?? []
        data[.Education] = educationDataRepository.getAll() ?? []
        data[.Skills] = skillDataRepository.getAll() ?? []
        
        return createModel()
    }
    
    func createModel() -> PdfModel {
        let model = PdfModel(pageSize: PdfModel.defaultPageSize,
                             content: VerticalPdfComponent(subComponents: [
                                getAboutSection(),
                                getDetailsComponent()
                             ]))
        
        return model
    }
    
    func getAboutSection() -> HorizontalPdfComponent {
        guard let aboutModel = data[.About] as? AboutModel
            else {return HorizontalPdfComponent(subComponents: [])}
        
        return HorizontalPdfComponent(subComponents: [
            VerticalPdfComponent(widthRatio: 0.4,
                                 subComponents: [
                                 ElementPdfComponent(element: TextPdfElement(fontSize: 15,
                                                                             fontWeight: .heavy,
                                                                             foregroundColor: .cyan,
                                                                             text: aboutModel.aboutText))
                                 ]),
            VerticalPdfComponent(widthRatio: 0.2,
                                 subComponents: [
                                 ElementPdfComponent(element: ImagePdfElement(isRounded: true, image: UIImage(named: "profileImage")!))
                                 ]),
            VerticalPdfComponent(widthRatio: 0.4,
                                 subComponents: [
                                 ElementPdfComponent(element: TextPdfElement(fontSize: 15,
                                                                             fontWeight: .heavy,
                                                                             foregroundColor: .blue,
                                                                             text: aboutModel.aboutText))
                                 ])
        ])
    }
    
    func getDetailsComponent() -> HorizontalPdfComponent {
        guard let experiences = data[.Experience] as? [ExperienceModel],
              let educations = data[.Education] as? [EducationModel],
              let skills = data[.Skills] as? [SkillModel]
        else {return HorizontalPdfComponent.defaultInstance}
        
        return HorizontalPdfComponent(subComponents: [
            VerticalPdfComponent(widthRatio: 0.5,
                                 subComponents: [
                                    getExperiencesComponent(experiences)
                                 ]),
            VerticalPdfComponent(widthRatio: 0.5,
                                 subComponents: [
                                    getSkillSection(skills),
                                    getEducationComponent(educations)
                                 ])
        ])
        
    }
    
    func getExperiencesComponent(_ experiences: [ExperienceModel]) -> VerticalPdfComponent {
        var subComponents: [PdfComponent] = [ElementPdfComponent(element: TextPdfElement(fontSize: 30,
                                                                         fontWeight: .heavy,
                                                                         foregroundColor: .black,
                                                                         text: "Work Experience"))]
        subComponents.append(contentsOf: experiences.map({getSingleExperienceComponent(experience: $0)}))
        return VerticalPdfComponent(subComponents: subComponents)
    }
    
    func getSkillSection(_ skills: [SkillModel]) -> VerticalPdfComponent {
        return VerticalPdfComponent(subComponents: [
            ElementPdfComponent(element: TextPdfElement(fontSize: 30,
                                                        fontWeight: .heavy,
                                                        foregroundColor: .black,
                                                        text: "Skills")),
            ElementPdfComponent(element: TextPdfElement(fontSize: 15,
                                                        fontWeight: .medium,
                                                        foregroundColor: .black,
                                                        text: skills.map({$0.name}).joined(separator: " , ")))
        ])
    }
    
    func getEducationComponent(_ educations: [EducationModel]) -> VerticalPdfComponent {
        var subComponents: [PdfComponent] =  [ElementPdfComponent(element: TextPdfElement(fontSize: 30,
                                                                         fontWeight: .heavy,
                                                                         foregroundColor: .black,
                                                                         text: "Education"))]
        subComponents.append(contentsOf: educations.map({getSingleEducationComponent(education: $0)}))
        
        return VerticalPdfComponent(subComponents: subComponents)
    }
    
    func getSingleExperienceComponent(experience: ExperienceModel) -> VerticalPdfComponent {
        return VerticalPdfComponent(subComponents: [
            ElementPdfComponent(element: TextPdfElement(fontSize: 19, fontWeight: .black, foregroundColor: .black, text: experience.designation)),
            ElementPdfComponent(element: TextPdfElement(fontSize: 15, fontWeight: .bold, foregroundColor: .black, text: experience.companyName)),
            ElementPdfComponent(element: TextPdfElement(fontSize: 10, fontWeight: .light, foregroundColor: .gray, text: Utils.getTimeLineString(startDate: experience.startDate, endDate: experience.endDate, isPresent: experience.isPresent, dateFormatter: dateFormatter))),
            ElementPdfComponent(element: TextPdfElement(fontSize: 15, fontWeight: .medium, foregroundColor: .black, text: experience.roleDescription)),
        ])
    }
    
    func getSingleEducationComponent(education: EducationModel) -> VerticalPdfComponent {
        return VerticalPdfComponent(subComponents: [
            ElementPdfComponent(element: TextPdfElement(fontSize: 19, fontWeight: .black, foregroundColor: .black, text: education.institution)),
            ElementPdfComponent(element: TextPdfElement(fontSize: 15, fontWeight: .bold, foregroundColor: .black, text: education.degree + " " + education.fieldOfStudy )),
            ElementPdfComponent(element: TextPdfElement(fontSize: 10, fontWeight: .light, foregroundColor: .gray, text: Utils.getTimeLineString(startDate: education.startDate, endDate: education.endDate, isPresent: education.isPresent, dateFormatter: dateFormatter))),
            ElementPdfComponent(element: TextPdfElement(fontSize: 15, fontWeight: .medium, foregroundColor: .black, text: education.grade))
        ])
    }
}
