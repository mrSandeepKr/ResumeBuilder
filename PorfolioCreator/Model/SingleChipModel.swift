//
//  SingleChipModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 04/04/23.
//

import Foundation
import UIKit

struct SingleChipModel {
    let labelText: String
    let isDismissable: Bool
    let color: UIColor
    let horizontalMargin: CGFloat
    let verticalMargin: CGFloat
    let cornerRadius: CGFloat
    let fontSize: CGFloat
    let buttonMargin: CGFloat
    
    init(labelText: String,
         isDismissable: Bool,
         color: UIColor,
         horizontalMargin: CGFloat = 5,
         verticalMargin: CGFloat = 5,
         cornerRadius: CGFloat = 5 ,
         fontSize: CGFloat = 5,
         buttonMargin: CGFloat = 3) {
        self.labelText = labelText
        self.isDismissable = isDismissable
        self.color = color
        self.horizontalMargin = horizontalMargin
        self.verticalMargin = verticalMargin
        self.cornerRadius = cornerRadius
        self.fontSize = fontSize
        self.buttonMargin = buttonMargin
    }
}
