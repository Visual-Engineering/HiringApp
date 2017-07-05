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
    
    // Text
    static let labelText = R.string.localizable.cf_formSentTitle()
    static let buttonTitleText = R.string.localizable.cf_formSentButton()
    
    // Constraints
    static let labelWidthMultiplier: CGFloat = 0.8
    static let buttonTopMargin: CGFloat = 50.0
    static let buttonWidthMultiplier: CGFloat = 0.5
    static let buttonHeightConstant: CGFloat = 30.0
}

class ContactFormSentViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = Constants.labelText
        label.style = Style.title3
        label.backgroundColor = Constants.labelBackgroundColor
        label.textColor = Constants.buttonTextColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.styledText = Constants.buttonTitleText
        button.setStyledTitleColor(Constants.brandBlue)
        button.isEnabled = true
        button.backgroundColor = Constants.buttonBackgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        setup()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        button.layer.cornerRadius = button.frame.size.height * 0.5
    }
    
    private func setup() {
        view.backgroundColor = Constants.brandBlue
    }
    
    private func layout() {
        
        view.addSubview(label)
        view.addSubview(button)
        
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.labelWidthMultiplier).isActive = true
        
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Constants.buttonTopMargin).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeightConstant).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.buttonWidthMultiplier).isActive = true
    }
}
