//
//  UIDateTextView.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 01/04/23.
//

import UIKit

class UIDateTextField: UIView {
    
    let headingLabelHeight: CGFloat
    let showHeading: Bool
    
    let headingLabelBottomMargin: CGFloat = 0
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return datePicker
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    private lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .natural
        return label
    }()
    
    private lazy var contentTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        
        textField.inputView = datePicker
        textField.inputAccessoryView = getToolBar()
        textField.leftView = getLeftView()
        textField.rightView = getRightView()
        
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        
        return textField
    }()
    
    init(headingLabelHeight: CGFloat = 11,
         showHeading: Bool = false) {
        self.headingLabelHeight = headingLabelHeight
        self.showHeading = showHeading
        super.init(frame: .zero)
        
        headingLabel.isHidden = !showHeading
        
        addSubviews([headingLabel, contentTextField])
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            headingLabel.topAnchor.constraint(equalTo: topAnchor),
            headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headingLabel.heightAnchor.constraint(equalToConstant: headingLabelHeight),
            headingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headingLabel.bottomAnchor.constraint(equalTo: contentTextField.topAnchor, constant: headingLabelBottomMargin)
        ])
        
        constraints.append(contentsOf: [
            contentTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentTextField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.priority = UILayoutPriority(999)
            }
        }
        
        return constraints
    }
     
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        contentValue = Date()
        
        return true
    }
}

// MARK: textField set up
extension UIDateTextField {
    private func getLeftView() -> UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
    }
    
    private func getRightView() -> UIView {
        let imageView = UIImageView(image: UIImage.init(systemName: "calendar"))
        imageView.frame = CGRect(x: 3, y: 3, width: 20, height: 20)
        imageView.tintColor = .tertiaryLabel
        
        let imageViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        imageViewContainer.addSubview(imageView)
        
        return imageViewContainer
    }
    
    private func getToolBar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 44.0)))
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        
        return toolbar
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let textFieldHeight = frame.height - (showHeading ? headingLabelHeight + headingLabelBottomMargin : 0) - 5
        
        contentTextField.font = UIFont.systemFont(ofSize: CGFloat(textFieldHeight / 1.22))
        headingLabel.font = UIFont.systemFont(ofSize: CGFloat(headingLabelHeight / 1.22))
    }
    
    @objc private func doneButtonTapped() {
        resignFirstResponder()
    }
    
    @objc private func datePickerValueChanged() {
        contentValue = datePicker.date
    }
}

extension UIDateTextField {
    var contentValue: Date {
        get {
            guard let dateString = contentTextField.text, let date = dateFormatter.date(from: dateString) else {
                return Date()
            }
            return date
        }
        set {
            contentTextField.text = dateFormatter.string(from: newValue)
        }
    }
    
    var headingText: String {
        get {
            return headingLabel.text ?? ""
        }
        set {
            headingLabel.text = newValue
        }
    }
    
    var dateFormat: String {
        get {
            return dateFormatter.dateFormat
        }
        set {
            dateFormatter.dateFormat = newValue
        }
    }
}
