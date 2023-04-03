//
//  FormViewModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 02/04/23.
//

import Foundation

class FormViewModel {
    let title: String
    let fields: [FormCellModel]
    
    init(title: String, fields: [FormCellModel]) {
        self.title = title
        self.fields = fields
    }
}
