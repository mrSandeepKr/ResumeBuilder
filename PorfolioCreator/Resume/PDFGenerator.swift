//
//  PDFGenerator.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 12/04/23.
//

import PDFKit

protocol PDFGenerator {
    func getPdfView(for model: PdfModel) -> UIView
}
