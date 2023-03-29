//
//  AboutModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

class AboutModel: SectionBaseModel {
    let aboutText: String
    
    init(aboutText: String) {
        self.aboutText = aboutText
        
        super.init(sectionType: .About)
    }
}
