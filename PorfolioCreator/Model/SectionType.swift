//
//  SectionType.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

enum SectionType: String, CaseIterable {
    case About
    case Experience
    case Education
    case Skills
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .About
        case 1:
            self = .Experience
        case 2:
            self = .Education
        case 3:
            self = .Skills
        default:
            return nil
        }
    }
}
