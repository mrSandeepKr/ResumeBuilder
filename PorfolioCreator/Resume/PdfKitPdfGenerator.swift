//
//  PdfKitPdfGenerator.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 15/04/23.
//

import PDFKit

class PdfKitPdfGenerator: PDFGenerator {
    func getPdfView(for model: PdfViewModel) -> UIView {
        let pdfData = generate(from: model)
        let pdfDocument = PDFDocument(data: pdfData!)
        
        let pdfView = PDFView()
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.displayDirection = .vertical
        pdfView.displayMode = .singlePageContinuous
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        
        return pdfView
    }
    
    func generate(from model: PdfViewModel) -> Data? {
        let renderer = UIGraphicsPDFRenderer(bounds: model.pageRect)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            
            render(model.content, from: .zero, width:model.pageSize.width)
        }
        return data
    }
    
    private func render(_ component: PdfComponent, from startingPoint: CGPoint, width: CGFloat) -> CGRect {
        var point = startingPoint
        var height: CGFloat = 0
        
        switch component.pdfComponentType {
            
        case .horizontal:
            guard let horizontalComponent = component as? HorizontalPdfComponent else {return .zero}
            
            for subComponent in horizontalComponent.subComponents {
                let rect = render(subComponent, from: point, width: width * CGFloat(subComponent.widthRatio))
                point = CGPoint(x: rect.maxX, y: startingPoint.y)
                height = max(height, rect.height)
            }
            
        case .vertical:
            guard let verticalComponent = component as? VerticalPdfComponent else {return .zero}
            for subComponent in verticalComponent.subComponents {
                let rect = render(subComponent, from: point, width: width * CGFloat(subComponent.widthRatio))
                point = CGPoint(x: startingPoint.x, y: rect.maxY)
                height += rect.height
            }
            
        case .element:
            guard let elementComponent = component as? ElementPdfComponent else {return .zero}
            let rect = render(elementComponent.element,from: point, width: width)
            height = rect.height
        }
        
        return CGRect(origin: startingPoint, size: CGSize(width: width, height: height))
    }
    
    private func render(_ element: PdfElement,from startingPoint: CGPoint, width: CGFloat) -> CGRect {
        switch element.pdfElementType {
            case .image:
            guard let imageElement = element as? ImagePdfElement else {return .zero}
            return render(imageElement, from: startingPoint, width: width)
            
            case .text:
            guard let textElement = element as? TextPdfElement else {return .zero}
            return render(textElement, from: startingPoint, width: width)
        }
    }
    
    func render(_ element: TextPdfElement, from startingPoint: CGPoint, width: CGFloat) -> CGRect {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = element.textAlignment
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: element.fontSize, weight: element.fontWeight),
            .foregroundColor: element.foregroundColor,
            .paragraphStyle: paragraphStyle,
        ]
        let containerSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingRect = NSString(string: element.text).boundingRect(with: containerSize,
                                                                       options: .usesLineFragmentOrigin,
                                                                       attributes: attributes,
                                                                       context: nil)
        let containerRect = CGRect(origin: startingPoint, size: boundingRect.size)
        
        NSAttributedString(string: element.text, attributes: attributes).draw(in: containerRect)
        
        return containerRect
    }
    
    func render(_ element: ImagePdfElement, from startingPoint: CGPoint, width: CGFloat) -> CGRect {
        let imageSize = width * 0.8
        let margin = width * 0.1
        let imageRect = CGRect(x: startingPoint.x + margin, y: startingPoint.y + margin, width: imageSize, height: imageSize)
        
        let renderer = UIGraphicsImageRenderer(bounds: imageRect)
        let circularImage = renderer.image { context in
            let path = UIBezierPath(ovalIn: imageRect)
            path.addClip()
            element.image.draw(in: imageRect)
            
            let borderPath = UIBezierPath(ovalIn: imageRect.insetBy(dx: -2, dy: -2))
                UIColor.gray.setStroke()
                borderPath.lineWidth = 10
                
                borderPath.stroke()
        }
        circularImage.draw(in: imageRect)
        
        return CGRect(origin: startingPoint, size: CGSize(width: imageSize, height: imageSize))
    }
    
}
