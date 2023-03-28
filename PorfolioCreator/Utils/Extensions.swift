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
