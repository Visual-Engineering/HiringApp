//
//  WalkthroughPageFour.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

class WalkthroughPageFourViewController: UIViewController {
    
    enum Constants {
        static let blueBackground : UIColor = UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
        static let buttonBackgroundColor: UIColor = .white
        static let buttonFontColor: UIColor = UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 100.0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    let buttonTop: UIButton = {
        let button = UIButton()
        button.setTitle("Saber más sobre Visual Engineering", for: .normal)
        button.backgroundColor = Constants.buttonBackgroundColor
        button.setTitleColor(Constants.buttonFontColor, for: .normal)
        return button
    }()
    
    let buttonBottom: UIButton = {
        let button = UIButton()
        button.setTitle("Trabajar con nostros", for: .normal)
        button.backgroundColor = Constants.buttonBackgroundColor
        button.setTitleColor(Constants.buttonFontColor, for: .normal)
        return button
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    //MARK: - Private API
    private func layout() {
        view.addSubviewWithAutolayout(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setup() {
        view.backgroundColor = Constants.blueBackground
        
        stackView.addArrangedSubview(buttonTop)
        stackView.addArrangedSubview(buttonBottom)
    }
}
