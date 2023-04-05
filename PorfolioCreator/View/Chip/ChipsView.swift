//
//  ChipView.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 04/04/23.
//

import UIKit

struct ChipsModel {
    var singleChipModels: [SingleChipModel]
    let viewLeftMargin: CGFloat
    let viewRightMargin: CGFloat
    let chipVerticalMargin: CGFloat
    let chipHorizontalMargin: CGFloat
    let viewWidth: CGFloat
    
    init(singleChipModels: [SingleChipModel],
         viewLeftMargin: CGFloat = 15,
         viewRightMargin: CGFloat = 30,
         chipVerticalMargin: CGFloat = 5,
         chipHorizontalMargin: CGFloat = 8,
         viewWidth: CGFloat = UIScreen.main.bounds.width) {
        self.singleChipModels = singleChipModels
        self.viewLeftMargin = viewLeftMargin
        self.viewRightMargin = viewRightMargin
        self.chipVerticalMargin = chipVerticalMargin
        self.chipHorizontalMargin = chipHorizontalMargin
        self.viewWidth = viewWidth
    }
}

protocol ChipsViewProtocol {
    func removeChip(singleChipModel: SingleChipModel)
}

class ChipsView: UIView {
    var maxY: CGFloat = 0
    var delegate: ChipsViewProtocol?
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildChipView(model: ChipsModel) {
        subviews.forEach({$0.removeFromSuperview()})
        
        var xPos: CGFloat = model.viewLeftMargin
        var yPos: CGFloat = model.chipVerticalMargin
        
        for singleChipModel in model.singleChipModels {
            let chipView = SingleChipView(model: singleChipModel)
            let chipViewSize = chipView.sizeThatFits(CGSize.init(width: 1000, height: 200))
            
            if xPos + model.chipHorizontalMargin + chipViewSize.width + model.viewRightMargin > model.viewWidth {
                xPos = model.viewLeftMargin
                yPos += chipViewSize.height + (2 * model.chipVerticalMargin)
                maxY = yPos + model.chipVerticalMargin + chipViewSize.height
            }
            
            chipView.frame = CGRect(origin: CGPoint.init(x: xPos, y: yPos), size: chipViewSize)
            chipView.delegate = self
            
            addSubview(chipView)
            
            xPos +=  model.chipHorizontalMargin + chipView.frame.width
        }
    }
    
    func getApproxHeight() -> CGFloat {
        return maxY
    }
}

extension ChipsView: SingleChipViewProtocol {
    func removeChip(singleChipModel: SingleChipModel) {
        delegate?.removeChip(singleChipModel: singleChipModel)
    }
}


