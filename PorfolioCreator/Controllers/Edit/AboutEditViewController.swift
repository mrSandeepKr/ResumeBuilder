//
//  AboutEditViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 31/03/23.
//

import UIKit

class AboutEditViewModel {
    
}

class AboutEditViewController: UIViewController {
    let aboutTextView: UICountingTextView = {
        let textView = UICountingTextView(maxCharCount: 50, showCharCount: true)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.contentTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.numberOfVisibleLines = 19
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "About"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissViewController))
        
        view.addSubview(aboutTextView)
        NSLayoutConstraint.activate(staticConstraints)
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
}
