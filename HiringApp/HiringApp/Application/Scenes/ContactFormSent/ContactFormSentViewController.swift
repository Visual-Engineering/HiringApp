//
//  ContactFormSent.swift
//  HiringApp
//
//  Created by Margareta Kusan on 03/07/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

private enum Constants {
    // Colors
    static let brandBlue: UIColor =  UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
    static let highlightedButtonColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    static let buttonTextColor: UIColor = .white
    static let labelBackgroundColor: UIColor = .clear
    static let buttonBackgroundColor: UIColor = .white
        
    // Constraints
    static let labelWidthMultiplier: CGFloat = 0.8
    static let buttonTopMargin: CGFloat = 50.0
    static let buttonWidthMultiplier: CGFloat = 0.5
    static let buttonHeightConstant: CGFloat = 30.0
}

class ContactFormSentViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.cf_formSentTitle()
        label.style = Style.title3
        label.backgroundColor = Constants.labelBackgroundColor
        label.textColor = Constants.buttonTextColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let button: RoundedButton = {
        let button = RoundedButton()
        button.styledText = R.string.localizable.cf_formSentButton()
        button.setStyledTitleColor(Constants.brandBlue)
        button.isEnabled = true
        button.backgroundColor = Constants.buttonBackgroundColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        button.layer.cornerRadius = button.frame.size.height * 0.5
    }
    
    private func setup() {
        button.addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
        view.backgroundColor = Constants.brandBlue
    }
    
    func continueButtonClicked() {
        dismiss(animated: true)
    }
    
    private func layout() {
        view.addSubviewWithAutolayout(label)
        view.addSubviewWithAutolayout(button)

        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.labelWidthMultiplier).isActive = true
        
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.buttonTopMargin).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeightConstant).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.buttonWidthMultiplier).isActive = true
    }
}
