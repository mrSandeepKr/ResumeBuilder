//
//  ExperienceEditViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 05/04/23.
//

import Foundation
import UIKit

class ExperienceEditViewController: UIViewController {
    
    let viewModel = ExperienceEditViewModel()
    
    let companyNameTextView: UICountingTextView = {
        let textView = UICountingTextView(maxCharCount: 50, showHeading: true, showCharCount: true)
        textView.headingText = "Company Name"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let designationTextView: UICountingTextView = {
        let textView = UICountingTextView(maxCharCount: 50, showHeading: true, showCharCount: true)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.headingText = "Designation"
        return textView
    }()
    
    let startDateTextView: UIDateTextField = {
        let textView = UIDateTextField(showHeading: true)
        textView.headingText = "Start date"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let endDateTextView: UIDateTextField = {
        let textView = UIDateTextField(showHeading: true)
        textView.headingText = "End date"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let roleDescriptionTextView: UICountingTextView = {
        let textView = UICountingTextView(maxCharCount: 400, showHeading: true, showCharCount: true)
        textView.numberOfVisibleLines = 3
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.headingText = "Role description"
        return textView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        title = "Edit experience"
        
        view.addSubviews([companyNameTextView, designationTextView, startDateTextView, endDateTextView, roleDescriptionTextView])
        NSLayoutConstraint.activate(staticConstraints)
        
        setUpBarButton()
    }
    
    func setUpBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(systemName: "xmark"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(dismissViewController))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Save",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(saveInfoAction))
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true)
    }
    
    @objc func saveInfoAction() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        let sideMargin: CGFloat = 15
        let singleLineTextInputHeight: CGFloat = 50
        let trippleLineTextInputHeight: CGFloat = 100
        let singleLineDateInputHeight: CGFloat = 40
        
        let verticalSpacing: CGFloat = 5
        
        constraints.append(contentsOf: [
            companyNameTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalSpacing),
            companyNameTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideMargin),
            companyNameTextView.heightAnchor.constraint(equalToConstant: singleLineTextInputHeight),
            companyNameTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
        ])
        
        constraints.append(contentsOf: [
            designationTextView.topAnchor.constraint(equalTo: companyNameTextView.bottomAnchor, constant: verticalSpacing),
            designationTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideMargin),
            designationTextView.heightAnchor.constraint(equalToConstant: singleLineTextInputHeight),
            designationTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
        ])
        
        constraints.append(contentsOf: [
            startDateTextView.topAnchor.constraint(equalTo: designationTextView.bottomAnchor, constant: verticalSpacing),
            startDateTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideMargin),
            startDateTextView.heightAnchor.constraint(equalToConstant: singleLineDateInputHeight),
            startDateTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
        ])
        
        constraints.append(contentsOf: [
            endDateTextView.topAnchor.constraint(equalTo: startDateTextView.bottomAnchor, constant: verticalSpacing),
            endDateTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideMargin),
            endDateTextView.heightAnchor.constraint(equalToConstant: singleLineDateInputHeight),
            endDateTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
        ])
        
        constraints.append(contentsOf: [
            roleDescriptionTextView.topAnchor.constraint(equalTo: endDateTextView.bottomAnchor, constant: verticalSpacing),
            roleDescriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideMargin),
            roleDescriptionTextView.heightAnchor.constraint(equalToConstant: trippleLineTextInputHeight),
            roleDescriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
        ])
        
        return constraints
    }
    
}
