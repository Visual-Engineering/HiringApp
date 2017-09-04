//
//  TechnologiesViewController.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit

private enum Constants {
    static let stackViewSpacing: CGFloat = 15.0
    static let titleTopMargin: CGFloat = 30.0
    static let stackViewTopMargin: CGFloat = 30.0
    static let stackViewHorizontalMargin: CGFloat = 20.0
    
    static let brandBlue: UIColor =  UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
    static let brandWhite: UIColor = .white
}

class TechnologiesViewController: UIViewController {

    // MARK: - Stored properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.which_technology()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.brandWhite
        return label
    }()
    
    let technologiesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    var presenter: TechnologiesPresenterProtocol!

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Private API
    private func layout() {
        
        view.backgroundColor = Constants.brandBlue
        
        view.addSubview(titleLabel)
        view.addSubview(technologiesStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: topLayoutGuide.bottomAnchor,
                constant: Constants.titleTopMargin),
            titleLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
            ])

        NSLayoutConstraint.activate([
            technologiesStackView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.stackViewTopMargin),
            technologiesStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.stackViewHorizontalMargin),
            technologiesStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.stackViewHorizontalMargin)
            ])
    }
}

extension TechnologiesViewController: TechnologiesUserInterfaceProtocol {
    func configureFor(viewModel: TechnologiesViewModel) {
        
        technologiesStackView.clear()
                
        for (index, technology) in viewModel.techs.enumerated() {
            let button = RoundedButton()
            button.setTitle(technology.title, for: .normal)
            button.backgroundColor = Constants.brandWhite
            button.setTitleColor(Constants.brandBlue, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(technologyTapped), for: .touchUpInside)
            technologiesStackView.addArrangedSubview(button)
        }
    }

    func technologyTapped(sender: UIButton) {
        presenter.didClickOnTechnology(index: sender.tag)
    }
}
