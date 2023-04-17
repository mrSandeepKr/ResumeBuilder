//
//  PdfComponent.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 14/04/23.
//

import Foundation

enum PdfComponentType {
    case horizontal
    case vertical
    case element
}

protocol PdfComponent {
    var pdfComponentType: PdfComponentType {get}
    
    var widthRatio: Float {get set}
}

struct HorizontalPdfComponent: PdfComponent {
    var widthRatio: Float
    
    var pdfComponentType: PdfComponentType = .horizontal
    
    var subComponents: [PdfComponent]
    
    init(widthRatio: Float = 1.0, subComponents: [PdfComponent]) {
        self.widthRatio = widthRatio
        self.subComponents = subComponents
    }
    
    static let defaultInstance = HorizontalPdfComponent(subComponents: [])
}

struct VerticalPdfComponent: PdfComponent {
    var widthRatio: Float
    
    var pdfComponentType: PdfComponentType = .vertical
    
    var subComponents: [PdfComponent]
    
    init(widthRatio: Float = 1.0, subComponents: [PdfComponent]) {
        self.widthRatio = widthRatio
        self.subComponents = subComponents
    }
    
    static let defaultInstance = VerticalPdfComponent(subComponents: [])
}

struct ElementPdfComponent: PdfComponent {
    var widthRatio: Float = 1.0
    
    var pdfComponentType: PdfComponentType = .element
    
    var element: PdfElement
    
    init(widthRatio: Float = 1.0, element: PdfElement) {
        self.widthRatio = widthRatio
        self.element = element
    }
}
