//
//  PdfModel.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 13/04/23.
//

import UIKit

struct PdfModel {
    let pageSize: CGSize
    let content: PdfComponent
    
    var pageRect: CGRect {
        return CGRect(origin: .zero, size: pageSize)
    }
    
    static var defaultPageSize: CGSize {
        return CGSize(width: 8.5 * 72.0, height:11 * 72.0)
    }
    
    static var defaultInstance: PdfModel {
        return PdfModel(pageSize: defaultPageSize, content: getContent)
    }
    
    static var getContent: PdfComponent {
        let aboutText = "I have always been passionate about technology, which lead me to become a software engineer. Love to learn new thing and take up new challenges."
        return VerticalPdfComponent(subComponents: [
                                    HorizontalPdfComponent(widthRatio: 1.0, subComponents: [
                                        VerticalPdfComponent(widthRatio: 0.4, subComponents: [
                                            ElementPdfComponent(element: TextPdfElement(fontSize: 30,
                                                                                        fontWeight: .heavy,
                                                                                        foregroundColor: .blue,
                                                                                        text: "Sandeep Kumar")),
                                            ElementPdfComponent(element: TextPdfElement(fontSize: 15,
                                                                                        fontWeight: .medium,
                                                                                        foregroundColor: .blue,
                                                                                        text: "Software Engineer")),
                                            ElementPdfComponent(element: TextPdfElement(fontSize: 10,
                                                                                        fontWeight: .light,
                                                                                        foregroundColor: .blue,
                                                                                        text: aboutText)),
                                        ]),
                                        ElementPdfComponent(widthRatio: 0.2, element: ImagePdfElement(isRounded: true,
                                                                                                      image: UIImage(named: "profileImage")!)
                                        ),
                                        VerticalPdfComponent(widthRatio: 0.4, subComponents: [
                                            ElementPdfComponent(element: TextPdfElement(fontSize: 15,
                                                                                        fontWeight: .medium,
                                                                                        foregroundColor: .red,
                                                                                        text: "medium")),
                                            ElementPdfComponent(element: TextPdfElement(fontSize: 15,
                                                                                        fontWeight: .medium,
                                                                                        foregroundColor: .red,
                                                                                        text: "twitter")),
                                            ElementPdfComponent(element: TextPdfElement(fontSize: 15,
                                                                                        fontWeight: .medium,
                                                                                        foregroundColor: .red,
                                                                                        text: "leetcode")),
                                            ElementPdfComponent(element: TextPdfElement(fontSize: 15,
                                                                                        fontWeight: .medium,
                                                                                        foregroundColor: .red,
                                                                                        text: "8002702560")),
                                            ElementPdfComponent(element: TextPdfElement(fontSize: 15,
                                                                                        fontWeight: .medium,
                                                                                        foregroundColor: .red,
                                                                                        text: "sandeepkrofc@gmail.com")),
                                        ]),
                                    ])
        ])
        
        
    }
}


