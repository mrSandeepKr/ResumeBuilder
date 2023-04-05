//
//  EducationListViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 31/03/23.
//

import UIKit

class EducationListViewController: UIViewController {
    let viewModel: EducationListViewModel = EducationListViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EducationSectionTableViewCell.self, forCellReuseIdentifier: EducationSectionTableViewCell.reusableIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Education"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(launchEmptyFormViewController))
        
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

extension EducationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EducationSectionTableViewCell.reusableIdentifier) as? EducationSectionTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.configureCell(model: viewModel.content[indexPath.row], showEditButton: true)
        cell.buttonClickCallback = {[weak self] in
            self?.launchFormViewController(experienceModel: nil)
        }
        
        return cell
    }
    
    @objc func launchEmptyFormViewController() {
        launchFormViewController(experienceModel: nil)
    }
    
    func launchFormViewController(experienceModel: ExperienceModel?) {
        let vc = FormViewController(viewModel:
                                        FormViewModel.init(title: "Education",
                                                           fields: [FormTextInputCellModel.init(cellLabel: "Institution name",
                                                                                                maximumNumberOfLines: 1)]))
        vc.navigationItem.largeTitleDisplayMode = .always
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.prefersLargeTitles = true
        
        navigationController?.present(nav, animated: true)
    }
}
