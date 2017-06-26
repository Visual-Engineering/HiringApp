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
    
    static let brandBlue: UIColor = .blue
    static let brandWhite: UIColor = .white
}

class TechnologiesViewController: UIViewController {

    //MARK: - Stored properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "¿Cuál es tu tecnología?"
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

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter.viewDidLoad()
    }

    //MARK: - Private API
    private func layout() {
        
        view.backgroundColor = Constants.brandBlue
        
        view.addSubview(titleLabel)
        view.addSubview(technologiesStackView)
        
        titleLabel.topAnchor(equalTo: topLayoutGuide.bottomAnchor, constant: Constants.titleTopMargin)
        titleLabel.centerXAnchor(equalTo: view.centerXAnchor)
        
        technologiesStackView.topAnchor(equalTo: titleLabel.bottomAnchor, constant: Constants.stackViewTopMargin)
        technologiesStackView.leadingAnchor(equalTo: view.leadingAnchor, constant: Constants.stackViewHorizontalMargin)
        technologiesStackView.trailingAnchor(equalTo: view.trailingAnchor, constant: -Constants.stackViewHorizontalMargin)
    }
}

extension TechnologiesViewController: TechnologiesUserInterfaceProtocol {
    func configureFor(viewModel: TechnologiesViewModel) {
        
        technologiesStackView.clear()
        
        viewModel.technologies.forEach { (technology) in
            let button = UIButton()
            button.setTitle(technology, for: .normal)
            button.backgroundColor = Constants.brandWhite
            button.setTitleColor(Constants.brandBlue, for: .normal)
            technologiesStackView.addArrangedSubview(button)
        }
    }
}

