//
//  PDFViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 13/04/23.
//

import Foundation
import UIKit

class PDFViewController: UIViewController {
    let pdfGenerator = PdfKitPdfGenerator()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        let pdfModel = PdfViewModel.defaultInstance
        let pdfView = pdfGenerator.getPdfView(for: pdfModel)
        
        view.addSubview(pdfView)
        NSLayoutConstraint.constraintEdges(view: pdfView, toLayoutGuide: view.safeAreaLayoutGuide)
    }
}
