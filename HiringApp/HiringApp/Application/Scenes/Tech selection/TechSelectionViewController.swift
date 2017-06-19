//
//  TechSelectionViewController.swift
//  HiringApp
//
//  Created by Alejandro Garcia on 19/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit

class TechSelectionViewController: UIViewController {

    //MARK: - Stored properties
    fileprivate let titleLabel = UILabel()
    fileprivate let technologiesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 35.0

        return stackView
    }()

    var presenter: TechSelectionPresenterProtocol!

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter.viewDidLoad()
    }

    //MARK: - Private API
    private func layout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        technologiesStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        view.addSubview(technologiesStackView)

        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35.0).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        technologiesStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50.0).isActive = true
        technologiesStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        technologiesStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
}

extension TechSelectionViewController: TechSelectionUserInterfaceProtocol {

    func configureFor(viewModel: TechSelectionViewModel) {
        prepareView()

        view.backgroundColor = .blue

        titleLabel.text = viewModel.title
        titleLabel.textColor = .black

        for tech in viewModel.techs {
            let techButton = UIButton()
            techButton.setTitle(tech.title, for: .normal)
            techButton.setTitleColor(.black, for: .normal)
            techButton.backgroundColor = .white
            technologiesStackView.addArrangedSubview(techButton)
        }
    }

    //MARK: - Private API
    private func prepareView() {
        technologiesStackView.arrangedSubviews.forEach { (view) in
            technologiesStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
