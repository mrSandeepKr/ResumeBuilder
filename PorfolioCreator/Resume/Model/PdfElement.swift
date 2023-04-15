//
//  PdfElement.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 14/04/23.
//

import UIKit

enum PdfElementType {
    case text
    case image
}

protocol PdfElement {
    var pdfElementType: PdfElementType { get }
}

struct TextPdfElement: PdfElement {
    var pdfElementType: PdfElementType = .text
    
    let fontSize: CGFloat
    let fontWeight: UIFont.Weight
    let foregroundColor: UIColor
    let text: String
    let textAlignment: NSTextAlignment = .natural
}

struct ImagePdfElement: PdfElement {
    var pdfElementType: PdfElementType = .image
    
    let imageSize: CGFloat
    var isRounded: Bool
    var image: UIImage
}
