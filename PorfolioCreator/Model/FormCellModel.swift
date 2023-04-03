//
//  FormCellModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 02/04/23.
//

import Foundation

enum FormCellType {
    case text
    case date
}

protocol FormCellModel {
    var formCellType: FormCellType {get}
    var cellLabel: String {get set}
}

class FormTextInputCellModel: FormCellModel {
    var formCellType: FormCellType = .text
    var cellLabel: String
    var maximumNumberOfLines: Int
    
    init(cellLabel: String,
         maximumNumberOfLines: Int) {
        self.cellLabel = cellLabel
        self.maximumNumberOfLines = maximumNumberOfLines
    }
}

class FormDateInputCellModel: FormCellModel {
    var cellLabel: String
    var formCellType: FormCellType = .date
    
    init(cellLabel: String) {
        self.cellLabel = cellLabel
    }
}
