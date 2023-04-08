//
//  AboutRepository.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 08/04/23.
//

import Foundation

protocol AboutRepository {
    func getAboutString() -> String
    func updateAboutString(with aboutString: String)
}

struct AboutDataRepository: AboutRepository {
    let ABOUT_KEY = "about_key"
    
    func getAboutString() -> String {
        return UserDefaults.standard.string(forKey: ABOUT_KEY) ?? ""
    }
    
    func updateAboutString(with aboutString: String) {
        UserDefaults.standard.set(aboutString, forKey: ABOUT_KEY)
    }
}
