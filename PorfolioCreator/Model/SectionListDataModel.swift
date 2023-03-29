//
//  SectionListDataModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

class SectionListDataModel {
    let sectionType: SectionType
    var content: [SectionBaseModel]
    
    init(sectionType: SectionType, content: [SectionBaseModel]) {
        self.sectionType = sectionType
        self.content = content
    }
}
