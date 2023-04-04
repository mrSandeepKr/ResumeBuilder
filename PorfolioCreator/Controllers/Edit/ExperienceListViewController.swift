//
//  ExperienceListViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 31/03/23.
//

import UIKit

class ExperienceListViewContoller: UIViewController {
    let viewModel: ExperienceEditViewModel = ExperienceEditViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExperienceSectionTableViewCell.self, forCellReuseIdentifier: ExperienceSectionTableViewCell.reusableIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Experience"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissViewController))
        
        Task.init {
            await viewModel.fetchData()
            await MainActor.run {
                tableView.reloadData()
            }
        }
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.constraintEdges(view: tableView, toLayoutGuide: view.safeAreaLayoutGuide)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}

extension ExperienceListViewContoller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExperienceSectionTableViewCell.reusableIdentifier) as? ExperienceSectionTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.configureCell(model: viewModel.content[indexPath.row], showEditButton: true)
        return cell
    }
}

