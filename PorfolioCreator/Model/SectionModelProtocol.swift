//
//  SectionModelProtocol.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

public class SectionBaseModel {
    let sectionType: SectionType
    
    init(sectionType: SectionType) {
        self.sectionType = sectionType
    }
}
