//
//  SkillsEditViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 31/03/23.
//

import UIKit

class SkillsEditViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        title = "Skills"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissViewController))
    }
    
    
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}
