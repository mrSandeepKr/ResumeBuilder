//
//  UICountingTextView.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 31/03/23.
//

import Foundation
import UIKit

class UICountingTextView: UIView {
    let countingLabelHeight: CGFloat
    let headingLabelHeight: CGFloat
    let maxCharCount: Int
    let showHeading: Bool
    let showCharCount: Bool
    
    let headingLabelBottomMargin: CGFloat = 0
    let countingLabelTopMargin: CGFloat = 2
    
    var numberOfVisibleLines: Float = 1
    
    // MARK: Subviews
    let headingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .natural
        return label
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = .zero
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 6
        
        return textView
    }()
    
    let countingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    // MARK: initializers
    init(countingLabelHeight: CGFloat = 12,
         headingLabelHeight: CGFloat = 11,
         maxCharCount: Int = 200,
         showHeading: Bool = false,
         showCharCount: Bool = false) {
        self.countingLabelHeight = countingLabelHeight
        self.headingLabelHeight = headingLabelHeight
        self.maxCharCount = maxCharCount
        self.showHeading = showHeading
        self.showCharCount = showCharCount
        
        super.init(frame: .zero)
        
        addSubviews([contentTextView, countingLabel, headingLabel])
        NSLayoutConstraint.activate(staticConstraints)
        
        headingLabel.isHidden = !showHeading
        countingLabel.isHidden = !showCharCount
        
        updateTextCount()
        
        contentTextView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            headingLabel.topAnchor.constraint(equalTo: topAnchor),
            headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headingLabel.heightAnchor.constraint(equalToConstant: showHeading ? headingLabelHeight : 0),
            headingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headingLabel.bottomAnchor.constraint(equalTo: contentTextView.topAnchor, constant: headingLabelBottomMargin)
        ])
        
        constraints.append(contentsOf: [
            countingLabel.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: countingLabelTopMargin),
            countingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countingLabel.heightAnchor.constraint(equalToConstant: showCharCount ? countingLabelHeight : 0),
            countingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            countingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        constraints.append(contentsOf: [
            contentTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.priority = UILayoutPriority(999)
            }
        }
        
        return constraints
    }
    
    
    // MARK: Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let verticalTextInset: CGFloat = 4
        let textViewHeight = frame.height - (showCharCount ? countingLabelHeight + countingLabelTopMargin : 0) - (showHeading ? headingLabelHeight + headingLabelBottomMargin : 0)
        contentTextView.textContainerInset = UIEdgeInsets.init(top: verticalTextInset, left: 4, bottom: verticalTextInset, right: 4)
        
        let singleLineHeight = (Float(textViewHeight)/numberOfVisibleLines) - 2
        contentTextView.font = UIFont.systemFont(ofSize: CGFloat(singleLineHeight / 1.22))
        
        headingLabel.font = UIFont.systemFont(ofSize: CGFloat(headingLabelHeight / 1.22))
        countingLabel.font = UIFont.systemFont(ofSize: CGFloat(countingLabelHeight / 1.22))
    }
    
    override func becomeFirstResponder() -> Bool {
        contentTextView.becomeFirstResponder()
    }
}

extension UICountingTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateTextCount()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        if newText.count > maxCharCount {
            return false
        }
        textView.scrollRangeToVisible(range)
        return true
    }
    
    func updateTextCount() {
        let wordCount: Int = contentTextView.text.count
        countingLabel.text = "\(wordCount)/\(maxCharCount)"
    }
}

extension UICountingTextView {
    public var contentValue: String {
        get {
            return contentTextView.text ?? ""
        }
        set {
            contentTextView.text = newValue
        }
    }
    
    public var headingText: String {
        get {
            return headingLabel.text ?? ""
        }
        set {
            headingLabel.text = newValue
        }
    }
}
