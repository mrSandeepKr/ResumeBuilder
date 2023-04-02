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
        let textView = UICountingTextView(maxCharCount: 50)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "About"
        view.backgroundColor = .systemBackground
        
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
    
}
