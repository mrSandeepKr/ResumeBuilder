//
//  ExperienceListViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 31/03/23.
//

import UIKit

class ExperienceListViewContoller: UIViewController {
    let viewModel: ExperienceListViewModel = ExperienceListViewModel()
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(launchEmptyFormViewController))
        
        updateExperiences()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.constraintEdges(view: tableView, toLayoutGuide: view.safeAreaLayoutGuide)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateExperiences),
                                               name: .UpdateExperience,
                                               object: nil)
    }
    
    @objc func updateExperiences() {
        Task.init {[weak self] in
            guard let self = self else {return}
            
            await viewModel.fetchData()
            await MainActor.run {[weak self] in
                guard let self = self else {return}
                tableView.reloadData()
            }
        }
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        cell.callback = {[weak self] in
            guard let self = self else {return}
            launchFormViewController(experienceModel: viewModel.content[indexPath.row],
                                     isCreatingExperience: false)
        }
        
        return cell
    }
    
    @objc func launchEmptyFormViewController() {
        launchFormViewController(experienceModel: ExperienceModel.defaultInstance,
                                 isCreatingExperience: true)
    }
    
    func launchFormViewController(experienceModel: ExperienceModel, isCreatingExperience: Bool) {
        let vc = ExperienceEditViewController(viewModel: ExperienceEditViewModel(experienceModel: experienceModel, isCreatingExperience: isCreatingExperience))
        vc.navigationItem.largeTitleDisplayMode = .always
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.prefersLargeTitles = true
        
        navigationController?.present(nav, animated: true)
    }
}

