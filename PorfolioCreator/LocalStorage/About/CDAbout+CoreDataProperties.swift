//
//  CDAbout+CoreDataProperties.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 09/04/23.
//
//

import Foundation
import CoreData


extension CDAbout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAbout> {
        return NSFetchRequest<CDAbout>(entityName: "CDAbout")
    }

    @NSManaged public var aboutText: String
    
    func convertToAbout() -> AboutModel {
        return AboutModel(aboutText: self.aboutText)
    }
    
    func update(with about: AboutModel) {
        self.aboutText = about.aboutText
    }
}
