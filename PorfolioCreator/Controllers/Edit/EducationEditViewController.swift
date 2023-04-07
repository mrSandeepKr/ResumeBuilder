//
//  EducationEditViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 05/04/23.
//

import UIKit

class EducationEditViewController: UIViewController {
    let viewModel: EducationEditViewModel
    
    let instituteNameTextView: UICountingTextView = {
        let textView = UICountingTextView(maxCharCount: 50, showHeading: true, showCharCount: true)
        textView.headingText = "Institute Name"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let degreeTextView: UICountingTextView = {
        let textView = UICountingTextView(maxCharCount: 50, showHeading: true, showCharCount: true)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.headingText = "Degree"
        return textView
    }()
    
    let fieldOfStudyTextView: UICountingTextView = {
        let textView = UICountingTextView(maxCharCount: 50, showHeading: true, showCharCount: true)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.headingText = "Field of study"
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
    
    let descriptionTextView: UICountingTextView = {
        let textView = UICountingTextView(maxCharCount: 400, showHeading: true, showCharCount: true)
        textView.numberOfVisibleLines = 3
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.headingText = "Description"
        return textView
    }()
    
    let gradeTextView: UICountingTextView = {
        let textView = UICountingTextView(maxCharCount: 400, showHeading: true, showCharCount: true)
        textView.numberOfVisibleLines = 1
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.headingText = "Grade/Score"
        return textView
    }()
    
    init(viewModel: EducationEditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        title = "Edit education"
        
        view.addSubviews([instituteNameTextView,
                          degreeTextView,
                          fieldOfStudyTextView,
                          startDateTextView,
                          endDateTextView,
                          descriptionTextView,
                          gradeTextView])
        
        NSLayoutConstraint.activate(staticConstraints)
        
        setUpBarButton()
        updateFields()
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
    
    func updateFields() {
        instituteNameTextView.contentValue = viewModel.educationModel.institution
        degreeTextView.contentValue = viewModel.educationModel.degree
        fieldOfStudyTextView.contentValue = viewModel.educationModel.fieldOfStudy
        startDateTextView.contentValue = viewModel.educationModel.startDate
        endDateTextView.contentValue = viewModel.educationModel.endDate
        descriptionTextView.contentValue = viewModel.educationModel.description
        gradeTextView.contentValue = viewModel.educationModel.grade
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
            instituteNameTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalSpacing),
            instituteNameTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideMargin),
            instituteNameTextView.heightAnchor.constraint(equalToConstant: singleLineTextInputHeight),
            instituteNameTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
        ])

        constraints.append(contentsOf: [
            degreeTextView.topAnchor.constraint(equalTo: instituteNameTextView.bottomAnchor, constant: verticalSpacing),
            degreeTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideMargin),
            degreeTextView.heightAnchor.constraint(equalToConstant: singleLineTextInputHeight),
            degreeTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
        ])

        constraints.append(contentsOf: [
            fieldOfStudyTextView.topAnchor.constraint(equalTo: degreeTextView.bottomAnchor, constant: verticalSpacing),
            fieldOfStudyTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideMargin),
            fieldOfStudyTextView.heightAnchor.constraint(equalToConstant: singleLineTextInputHeight),
            fieldOfStudyTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
        ])

        constraints.append(contentsOf: [
            startDateTextView.topAnchor.constraint(equalTo: fieldOfStudyTextView.bottomAnchor, constant: verticalSpacing),
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
            descriptionTextView.topAnchor.constraint(equalTo: endDateTextView.bottomAnchor, constant: verticalSpacing),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideMargin),
            descriptionTextView.heightAnchor.constraint(equalToConstant: trippleLineTextInputHeight),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
        ])

        constraints.append(contentsOf: [
            gradeTextView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: verticalSpacing),
            gradeTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideMargin),
            gradeTextView.heightAnchor.constraint(equalToConstant: singleLineTextInputHeight),
            gradeTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
        ])
        
        return constraints
    }
    
}
