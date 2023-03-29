//
//  Extensions.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 26/03/23.
//

import Foundation
import UIKit

extension UITableViewCell {
    static public var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        
        return size.width
    }
}
