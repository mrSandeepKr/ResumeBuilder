//
//  UICountingTextView.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 31/03/23.
//

import Foundation
import UIKit

class UICountingTextView: UIView {
    let labelHeight: CGFloat
    var maxCharCount: Int
    let countingLabelTopMargin: CGFloat = 2
    
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
    
    init(labelHeight: CGFloat = 12, maxCharCount: Int = 200) {
        self.labelHeight = labelHeight
        self.maxCharCount = maxCharCount
        
        super.init(frame: .zero)
        
        addSubview(contentTextView)
        addSubview(countingLabel)
        updateTextCount()
        contentTextView.delegate = self
        
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            contentTextView.topAnchor.constraint(equalTo: topAnchor),
            contentTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentTextView.bottomAnchor.constraint(equalTo: countingLabel.topAnchor, constant: -2),
            contentTextView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        constraints.append(contentsOf: [
            countingLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            countingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            countingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        return constraints
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = frame.height - countingLabelTopMargin - (countingLabel.constraints.first(where: {$0.firstAttribute == .height})?.constant ?? 0)
        let fontHeight = contentTextView.font?.lineHeight ?? height / 2
        
        contentTextView.textContainerInset = UIEdgeInsets(top: (height - fontHeight ) / 2, left: 5, bottom: 5, right: (height - fontHeight ) / 2)
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

extension UICountingTextView: FormFieldContentProtocol {
    public var contentValue: String {
        get {
            return contentTextView.text ?? ""
        }
        set {
            contentTextView.text = newValue
        }
    }
}
