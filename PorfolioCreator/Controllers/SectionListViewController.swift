//
//  SectionListViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 27/03/23.
//

import Foundation
import UIKit

class SectionListViewController: UIViewController {
    let viewModel = SectionListViewModel()
    
    let sectionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(ExperienceSectionTableViewCell.self, forCellReuseIdentifier: ExperienceSectionTableViewCell.reusableIdentifier)
        tableView.register(EducationSectionTableViewCell.self, forCellReuseIdentifier: EducationSectionTableViewCell.reusableIdentifier)
        tableView.register(AboutSectionTableViewCell.self, forCellReuseIdentifier: AboutSectionTableViewCell.reusableIdentifier)
        tableView.register(SkillSectionTableViewCell.self, forCellReuseIdentifier: SkillSectionTableViewCell.reusableIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Portfolio"
        view.backgroundColor = .systemBackground
        
        view.addSubview(sectionsTableView)
        sectionsTableView.delegate = self
        sectionsTableView.dataSource = self
        
        NSLayoutConstraint.activate(staticConstraints)
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            sectionsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sectionsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sectionsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sectionsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        return constraints
    }
}

extension SectionListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.data[section].sectionType.rawValue
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data[section].content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.data[indexPath.section].sectionType {
        case .About:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutSectionTableViewCell.reusableIdentifier, for: indexPath) as? AboutSectionTableViewCell,
                  let model = viewModel.data[indexPath.section].content[indexPath.row] as? AboutModel
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model)
            return cell
            
        case .Experience:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExperienceSectionTableViewCell.reusableIdentifier, for: indexPath) as? ExperienceSectionTableViewCell,
                  let model = viewModel.data[indexPath.section].content[indexPath.row] as? ExperienceModel
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model)
            return cell
            
        case .Education:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EducationSectionTableViewCell.reusableIdentifier, for: indexPath) as? EducationSectionTableViewCell,
                  let model = viewModel.data[indexPath.section].content[indexPath.row] as? EducationModel
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model)
            return cell
            
        case .Skills:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SkillSectionTableViewCell.reusableIdentifier, for: indexPath) as? SkillSectionTableViewCell,
                  let model = viewModel.data[indexPath.section].content[indexPath.row] as? SkillModel
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model)
            return cell
        }
    }
}
