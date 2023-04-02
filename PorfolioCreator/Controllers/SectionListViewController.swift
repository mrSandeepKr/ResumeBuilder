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
        tableView.allowsSelection = false
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let buttonSize = 40
        let button = UIButton(frame: CGRect(x: Int(tableView.frame.width) - 40 - 10, y: 5, width: buttonSize, height: buttonSize))
        button.setImage(UIImage.init(systemName: "pencil"), for: .normal)
        button.tag = section
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        let label = UILabel()
        label.text = viewModel.data[section].sectionType.rawValue
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = .black
        
        let size = label.sizeThatFits(CGSize(width: tableView.frame.width, height: tableView.frame.height))
        label.frame = CGRect(x: 20, y: 5, width: size.width, height: size.height)
        
        view.addSubview(label)
        view.addSubview(button)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    @objc func editButtonTapped(_ sender: UIButton) {
        guard let sectionType: SectionType = SectionType.init(rawValue: sender.tag)
        else {
            return
        }
        
        switch sectionType {
        case .About:
            break
        case .Experience:
                break
        case .Education:
                break
        case .Skills:
                break
        }
    }
}
