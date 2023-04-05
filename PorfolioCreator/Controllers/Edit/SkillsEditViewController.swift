//
//  SkillsEditViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 31/03/23.
//

import UIKit

class SkillsEditViewController: UIViewController {
    let viewModel = SkillsEditViewModel()
    let viewSideMargin: CGFloat = 15
    
    let skillsInputTextView: UICountingTextView = {
        let countingTextView = UICountingTextView(maxCharCount: 60)
        countingTextView.translatesAutoresizingMaskIntoConstraints = false
        countingTextView.contentTextView.font = UIFont.systemFont(ofSize: 15)
        countingTextView.contentTextView.textContainerInset = UIEdgeInsets(top: 5, left: 7, bottom: 7, right: 7)
        return countingTextView
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let chipsView: ChipsView = {
        let view = ChipsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        title = "Skills"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissViewController))
        
        view.addSubview(skillsInputTextView)
        view.addSubview(addButton)
        view.addSubview(chipsView)
        
        chipsView.delegate = self
        
        addButton.addTarget(self, action: #selector(addSkill), for: .touchUpInside)
        
        NSLayoutConstraint.activate(staticConstraints)
        
        updateChips()
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            skillsInputTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            skillsInputTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: viewSideMargin),
            skillsInputTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            skillsInputTextView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        constraints.append(contentsOf: [
            addButton.topAnchor.constraint(equalTo: skillsInputTextView.topAnchor),
            addButton.heightAnchor.constraint(equalTo: skillsInputTextView.heightAnchor, multiplier: 0.65),
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -viewSideMargin)
        ])
        
        constraints.append(contentsOf: [
            chipsView.topAnchor.constraint(equalTo: skillsInputTextView.bottomAnchor, constant: 10),
            chipsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chipsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 5),
            chipsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        return constraints
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc func addSkill() {
        if skillsInputTextView.contentValue.count < 3 {
            return
        }
        
        Task.init {
            await viewModel.addSkill(skillText: skillsInputTextView.contentValue)
            await MainActor.run(body: {
                skillsInputTextView.contentValue = ""
                updateChips()
            })
        }
    }
    
    func updateChips() {
        Task.init {
            await viewModel.fetchAndUpdateSkills()
            await MainActor.run(body: {
                let singleChipsModels = viewModel.skills.map({getChipModel($0)})
                chipsView.buildChipView(model: ChipsModel.init(singleChipModels: singleChipsModels, viewLeftMargin: viewSideMargin))
            })
        }
    }
    
    func getChipModel(_ skill: Skill) -> SingleChipModel {
        return SingleChipModel(skill: skill,
                                 isDismissable: true,
                                 color: .gray,
                                 horizontalMargin: 5,
                                 verticalMargin: 5,
                                 cornerRadius: 5,
                                 fontSize: 15)
    }
}

extension SkillsEditViewController: ChipsViewProtocol {
    func removeChip(singleChipModel: SingleChipModel) {
        Task.init {
            await viewModel.removeSkill(skill: singleChipModel.skill)
            await MainActor.run {
                updateChips()
            }
        }
    }
}
