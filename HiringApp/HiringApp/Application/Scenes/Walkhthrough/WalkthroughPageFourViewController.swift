//
//  WalkthroughPageFour.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit
import BWWalkthrough

class WalkthroughPageFourViewController: BWWalkthroughPageViewController {
    
    enum Constants {
        static let blueBackground : UIColor = UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
        static let buttonBackgroundColor: UIColor = .white
        static let buttonFontColor: UIColor = UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
        
        static let stackViewSpacing: CGFloat = 100.0
        static let stackViewSidesMargin: CGFloat = 30.0
        static let stackViewHeightAnchorMultiplier: CGFloat = 0.3
        
        static let buttonsFontSize: CGFloat = 16.0
        static let buttonsFontType: String = "Arial"
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.stackViewSpacing
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
        button.titleLabel?.font = UIFont(name: Constants.buttonsFontType, size: Constants.buttonsFontSize)
        return button
    }()
    
    let buttonBottom: UIButton = {
        let button = UIButton()
        button.setTitle("Trabajar con nostros", for: .normal)
        button.backgroundColor = Constants.buttonBackgroundColor
        button.setTitleColor(Constants.buttonFontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.buttonsFontType, size: Constants.buttonsFontSize)
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
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackViewSidesMargin).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackViewSidesMargin).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height * Constants.stackViewHeightAnchorMultiplier).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setup() {
        view.backgroundColor = .clear
        
        stackView.addArrangedSubview(buttonTop)
        stackView.addArrangedSubview(buttonBottom)
    }
    
    override func walkthroughDidScroll(to position: CGFloat, offset: CGFloat) {
        var tr = CATransform3DIdentity
        tr.m34 = -1/1000.0
        view.layer.transform = CATransform3DRotate(tr, CGFloat(Double.pi)  * (1.0 - offset), 0.5,1, 0.2)
    }
}


