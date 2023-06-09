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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(ExperienceSectionTableViewCell.self, forCellReuseIdentifier: ExperienceSectionTableViewCell.reusableIdentifier)
        tableView.register(EducationSectionTableViewCell.self, forCellReuseIdentifier: EducationSectionTableViewCell.reusableIdentifier)
        tableView.register(AboutSectionTableViewCell.self, forCellReuseIdentifier: AboutSectionTableViewCell.reusableIdentifier)
        tableView.register(SkillSectionTableViewCell.self, forCellReuseIdentifier: SkillSectionTableViewCell.reusableIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Portfolio"
        view.backgroundColor = .systemBackground
        
        view.addSubview(sectionsTableView)
        sectionsTableView.delegate = self
        sectionsTableView.dataSource = self
        
        sectionListNeedsUpdate()
        
        NSLayoutConstraint.activate(staticConstraints)
        
        NotificationCenter.default.addObserver(forNames: [.UpdateAbout, .UpdateSkill, .UpdateEducation, .UpdateExperience],
                                               target: self,
                                               selector: #selector(sectionListNeedsUpdate))
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
    
    @objc func sectionListNeedsUpdate() {
        Task.init {[weak self] in
            guard let self = self else {return}
            
            await self.viewModel.fetchData()
            await MainActor.run(body: {[weak self] in
                guard let self = self else {return}
                
                self.sectionsTableView.reloadData()
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExperienceSectionTableViewCell.reusableIdentifier, for: indexPath) as? ExperienceSectionTableViewCell
            else {
                return UITableViewCell()
            }
            
            guard let model = viewModel.data[indexPath.section].content[indexPath.row] as? ExperienceModel
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
                  let model = viewModel.data[indexPath.section].content[indexPath.row] as? SkillSectionModel
            else {
                return UITableViewCell()
            }
            cell.configureCell(model: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeight: CGFloat = 50
        let buttonSize: CGFloat = 40
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: sectionHeight))
        view.backgroundColor = .systemBackground
        
        let editButton = UIButton(frame: CGRect(x: tableView.frame.width - buttonSize - 10,
                                            y: (sectionHeight - buttonSize) / 2,
                                            width: buttonSize,
                                            height: buttonSize))
        editButton.setImage(UIImage.init(systemName: "pencil"), for: .normal)
        editButton.tag = section
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        let textView = UITextView()
        textView.text = viewModel.data[section].sectionType.rawValue
        textView.font = UIFont.boldSystemFont(ofSize: 24)
        textView.textColor = .black
        textView.isEditable = false
        textView.textContainerInset = .zero
        textView.isScrollEnabled = false
        
        let labelSize = textView.sizeThatFits(CGSize(width: tableView.frame.width, height: sectionHeight))
        textView.frame = CGRect(x: 10,
                             y: (sectionHeight - labelSize.height) / 2,
                             width: labelSize.width,
                             height: labelSize.height)
        
        view.addSubview(textView)
        view.addSubview(editButton)
        
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
        
        var vc: UIViewController? = nil
        switch sectionType {
        case .About:
            vc = AboutEditViewController()
        case .Experience:
            vc = ExperienceListViewContoller()
        case .Education:
            vc = EducationListViewController()
        case .Skills:
            let vm = SkillsEditViewModel()
            vc = SkillsEditViewController(viewModel: vm)
        }
        
        vc!.navigationItem.largeTitleDisplayMode = .always
        let nav = UINavigationController.init(rootViewController: vc!)
        
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.prefersLargeTitles = true
        navigationController?.present(nav, animated: true)
    }
}
