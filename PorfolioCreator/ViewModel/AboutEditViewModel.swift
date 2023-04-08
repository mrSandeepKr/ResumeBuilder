//
//  AboutEditViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 08/04/23.
//

import Foundation

class AboutEditViewModel {
    let repository: AboutRepository
    var aboutString: String
    
    init(repository: AboutRepository) {
        self.repository = repository
        aboutString = ""
    }
    
    func fetchData() async {
       aboutString =  repository.getAboutString()
    }
    
    func updateData(with aboutString: String) async {
        repository.updateAboutString(with: aboutString)
    }
}
