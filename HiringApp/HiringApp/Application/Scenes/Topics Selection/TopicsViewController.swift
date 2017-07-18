//
//  TopicsViewController.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 12/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController {
    
    fileprivate enum Constants {
        static let stackViewSpacing: CGFloat = 15.0
        static let titleTopMargin: CGFloat = 30.0
        static let stackViewTopMargin: CGFloat = 30.0
        static let stackViewHorizontalMargin: CGFloat = 20.0
        
        static let brandBlue: UIColor =  UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
        static let brandWhite: UIColor = .white
    }

    // MARK: - Stored properties
    var presenter: TopicsPresenterProtocol!
    
    // MARK: - Stored properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.which_technology()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.brandWhite
        label.text = R.string.localizable.which_topic()
        return label
    }()
    
    let topicsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.alignment = .fill
        return stackView
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter.viewDidLoad()
        layout()
    }

    // MARK: - Private API
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(topicsStackView)
        
        titleLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: Constants.titleTopMargin).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        topicsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.stackViewTopMargin).isActive = true
        topicsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackViewHorizontalMargin).isActive = true
        topicsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackViewHorizontalMargin).isActive = true
    }
    
    private func setup() {
        view.backgroundColor = Constants.brandBlue
    }
    
    func didClickOnTopic(sender: UIButton) {
        presenter.didClickOnTopic(index: sender.tag)
    }
}

extension TopicsViewController: TopicsUserInterfaceProtocol {
    func configureFor(viewModel: TopicsViewModel) {
        topicsStackView.clear()
        
        for (index, topic) in viewModel.topics.enumerated() {
            let button = RoundedButton()
            button.setTitle(topic.title, for: .normal)
            button.backgroundColor = Constants.brandWhite
            button.setTitleColor(Constants.brandBlue, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(didClickOnTopic), for: .touchUpInside)
            topicsStackView.addArrangedSubview(button)
        }
    }
}
