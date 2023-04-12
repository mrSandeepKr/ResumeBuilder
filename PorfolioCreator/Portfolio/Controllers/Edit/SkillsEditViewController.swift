//
//  SkillsEditViewController.swift
//  PorfolioCreator
//
//  Created by Sandeep Kumar on 31/03/23.
//

import UIKit

class SkillsEditViewController: UIViewController {
    let viewModel: SkillsEditViewModel
    let viewSideMargin: CGFloat = 15
    
    let skillsInputTextView: UICountingTextView = {
        let countingTextView = UICountingTextView(maxCharCount: 60,showHeading: false, showCharCount: true)
        countingTextView.translatesAutoresizingMaskIntoConstraints = false
        countingTextView.contentTextView.font = UIFont.systemFont(ofSize: 15)
        countingTextView.numberOfVisibleLines = 1
        
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
    
    init(viewModel: SkillsEditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        title = "Skills"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissViewController))
        
        view.addSubviews([skillsInputTextView, addButton, chipsView])
        NSLayoutConstraint.activate(staticConstraints)
        
        chipsView.delegate = self
        addButton.addTarget(self, action: #selector(addSkill), for: .touchUpInside)
        
        updateChips()
    }
    
    var staticConstraints: [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            skillsInputTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            skillsInputTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: viewSideMargin),
            skillsInputTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            skillsInputTextView.heightAnchor.constraint(equalToConstant: 40)
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
        
        Task.init {[weak self] in
            guard let self = self else {return}
            await viewModel.addSkill(skillText: skillsInputTextView.contentValue)
            await MainActor.run(body: {[weak self] in
                guard let self = self else {return}
                skillsInputTextView.contentValue = ""
                updateChips()
            })
        }
    }
    
    func updateChips() {
        Task.init {[weak self] in
            guard let self = self else {return}
            await viewModel.fetchAndUpdateSkills()
            await MainActor.run(body: {[weak self] in
                guard let self = self else {return}
                let singleChipsModels = viewModel.skills.map({self.getChipModel($0)})
                chipsView.buildChipView(model: ChipsModel.init(singleChipModels: singleChipsModels, viewLeftMargin: viewSideMargin))
            })
        }
    }
    
    func getChipModel(_ skill: SkillModel) -> SingleChipModel {
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
        Task.init {[weak self] in
            guard let self = self else {return}
            await viewModel.removeSkill(skill: singleChipModel.skill)
            await MainActor.run {[weak self] in
                guard let self = self else {return}
                updateChips()
            }
        }
    }
}
