//
//  AboutEditViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 08/04/23.
//

import Foundation

class AboutEditViewModel {
    let repository: AboutRepository
    var model: AboutModel
    
    init(repository: AboutRepository) {
        self.repository = repository
        model = AboutModel(aboutText: "")
    }
    
    func fetchData() async {
        model =  repository.getAbout()
    }
    
    func updateData(with aboutString: String) async {
        repository.update(with: AboutModel(aboutText: aboutString))
    }
}
