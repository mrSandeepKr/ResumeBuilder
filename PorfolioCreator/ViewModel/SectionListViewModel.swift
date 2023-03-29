//
//  SectionListViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 28/03/23.
//

import Foundation

class SectionListViewModel {
    var data = [SectionListDataModel]()
    
    init() {
        data = SectionType.allCases.map { sectionType in
            SectionListDataModel(sectionType: sectionType,content: [SectionBaseModel]())
        }
    }
    
    func fetchData() {
        // make the data base call
    }
}
