//
//  AboutEditViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 31/03/23.
//

import UIKit

class AboutEditViewController: UIViewController {
    let viewModel = AboutEditViewModel(repository: AboutDataRepository())
    
    let aboutTextView: UICountingTextView = {
        let textView = UICountingTextView(maxCharCount: 300, showCharCount: true)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.contentTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.numberOfVisibleLines = 19
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "About"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveButtonAction))
        
        view.addSubview(aboutTextView)
        NSLayoutConstraint.activate(staticConstraints)
        
        Task.init {
            await viewModel.fetchData()
            await MainActor.run(body: {[weak self] in
                guard let self = self else {return}
                self.aboutTextView.contentValue = self.viewModel.model.aboutText
            })
        }
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        let sideMargin: CGFloat = 15
        
        constraints.append(contentsOf: [
            aboutTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            aboutTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideMargin),
            aboutTextView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.6),
            aboutTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideMargin),
        ])
        
        return constraints
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonAction() {
        let aboutText = aboutTextView.contentValue
        Task.init {
            await viewModel.updateData(with: aboutText)
        }
    }
}
