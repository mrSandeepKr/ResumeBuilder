//
//  UIDateTextView.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 01/04/23.
//

import UIKit

class UIDateTextField: UITextField {
    var dateFormat: String {
        set {
            dateFormatter.dateFormat = newValue
        }
        get {
            return dateFormatter.dateFormat
        }
    }
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetUp()
    }
    
    private func commonSetUp() {
        // Set the date picker mode and add a target for value changes
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        // Set the input view to the date picker
        inputView = datePicker
        
        // corner radius border
        layer.cornerRadius = 10
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        
        setUpToolBar()
        setUpLeftView()
        setUpRightView()
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        text = dateFormatter.string(from: Date())
        
        return true
    }
    
    private func setUpLeftView() {
        leftViewMode = .always
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        
        leftView = view
    }
    
    private func setUpRightView() {
        rightViewMode = .always
        
        let imageView = UIImageView(image: UIImage.init(systemName: "calendar"))
        imageView.frame = CGRect(x: 3, y: 3, width: 20, height: 20)
        imageView.tintColor = .tertiaryLabel
        
        let imageViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 26, height: 26))
        imageViewContainer.addSubview(imageView)
        
        rightView = imageViewContainer
    }
    
    // Set the toolbar with a done button as the input accessory view
    private func setUpToolBar() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 44.0)))
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        
        inputAccessoryView = toolbar
    }
    
    // MARK: - Actions
    @objc private func doneButtonTapped() {
        resignFirstResponder()
    }
    
    @objc private func datePickerValueChanged() {
        text = dateFormatter.string(from: datePicker.date)
    }
}

extension UIDateTextField: FormFieldContentProtocol {
    var contentValue: String {
        get {
           return text ?? ""
        }
        set {
            text = newValue
        }
    }
}
