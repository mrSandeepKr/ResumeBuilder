//
//  AboutRepository.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 08/04/23.
//

import Foundation

protocol AboutRepository {
    func getAbout() -> AboutModel
    
    func update(with aboutModel: AboutModel)
}

struct AboutDataRepository: AboutRepository {
    func create(about: AboutModel) {
        let cdAbout = CDAbout(context: PersistentStorage.shared.context)
        cdAbout.update(with: about)
        PersistentStorage.shared.saveContext()
    }
    
    func getAbout() -> AboutModel {
        if let cdAbout = getCDAbout() {
            return cdAbout.convertToAbout()
        }
        
        return AboutModel(aboutText: "")
    }
    
    func update(with aboutModel: AboutModel) {
        if let cdAbout = getCDAbout() {
            cdAbout.update(with: aboutModel)
        }
        
        create(about: aboutModel)
    }
    
    // CDAbout is only a single value.
    // It can be debated that UserDefaults should be used.
    // But to ensure disparity, Core Data is being used.
    private func getCDAbout() -> CDAbout? {
        do {
            if let cdAboutList = try PersistentStorage.shared.context.fetch(CDAbout.fetchRequest()) as? [CDAbout],
                  let cdAbout = cdAboutList.first
            {
                return cdAbout
            }
        }
        catch {
            
        }
        
        return nil
    }
}
