//
//  SectionModelProtocol.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

public class SectionBaseModel {
    let sectionType: SectionType
    var content: [Any]
    
    init(sectionType: SectionType, content: [AnyObject]) {
        self.sectionType = sectionType
        self.content = content
    }
    
    func getContent(at idx: Int) -> Any? {
        if idx >= content.count {
            return nil
        }
        
        return content[idx]
    }
    
    var numberOfElementsInSection: Int {
        return content.count
    }
}
