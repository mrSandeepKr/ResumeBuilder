//
//  UIDateTextView.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 01/04/23.
//

import UIKit

class UIDateTextField: UITextField {
    
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
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        // Set the date picker mode and add a target for value changes
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        // Set the input view to the date picker
        inputView = datePicker
        
        // Set the toolbar with a done button as the input accessory view
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        
        inputAccessoryView = toolbar
        
        
        // left view
        let left_view = UIView(frame: .zero)
        leftView = left_view
        left_view.translatesAutoresizingMaskIntoConstraints = false
        leftV
    }
    
    
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        text = dateFormatter.string(from: Date())
        
        return true
    }
    
    func getLeftView() {
        
    }
    
    func getRightView() {
        let imageView = UIImageView(image: UIImage.syste)
    }
    
    // MARK: - Actions
    @objc private func doneButtonTapped() {
        resignFirstResponder()
    }
    
    @objc private func datePickerValueChanged() {
        text = dateFormatter.string(from: datePicker.date)
    }
}
