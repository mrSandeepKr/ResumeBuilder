//
//  FormEditViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 01/04/23.
//

import Foundation
import UIKit

class FormViewController: UIViewController {
    let viewModel: FormViewModel
    
    let formTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.reusableIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.init(red: 20/255.0, green: 102/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Save", for: .normal)
        
        return button
    }()
    
    init(viewModel: FormViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = viewModel.title
        
        view.addSubview(formTableView)
        formTableView.delegate = self
        formTableView.dataSource = self
        
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissViewController))
        
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            formTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            formTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            formTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            formTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
        constraints.append(contentsOf: [
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
        
        return constraints
    }
    
    @objc func saveButtonAction() {
        
    }
}

extension FormViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.reusableIdentifier) as? FormTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.configureCell(model: viewModel.fields[indexPath.row])
        return cell
    }
}

