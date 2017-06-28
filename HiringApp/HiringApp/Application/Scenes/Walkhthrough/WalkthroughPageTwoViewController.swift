//
//  WalkthroughPageTwo.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit
import BWWalkthrough

class WalkthroughPageTwoViewController: BWWalkthroughPageViewController {
    
    enum Constants {
        static let blueBackground : UIColor = UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
        static let topMarginMultiplierStackViewContainer: CGFloat = 0.05
        static let heightMultiplierStackViewContainer: CGFloat = 0.62
        static let lateralSpacingStackViewContainer: CGFloat = 40
        static let heightMultiplierStackViewChild: CGFloat = 0.2
    }
    
    private let arrayStringLogos = ["apple-logo","android-logo","windowsp-logo","js-logo"]
    
    //This stackView will contain all stackView childs
    private let stackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    private let stackViewLogos: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let stackViewLabelsTop: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.tag = 1
        
        return stackView
    }()
    
    private let stackViewLabelsMedium: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.tag = 2
        
        return stackView
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackViewsLabels()
        configureStackViewIcons()
        layout()
    }

    //MARK: - Private API
    private func layout() {
        view.backgroundColor = .clear
        
        edgesForExtendedLayout = []
        
        view.addSubviewWithAutolayout(stackViewContainer)
      
//        stackViewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant:self.view.frame.size.height*Constants.topMarginMultiplierStackViewContainer+navigationController?.navigationBar).isActive = true
        stackViewContainer.heightAnchor.constraint(equalToConstant: self.view.frame.size.height*Constants.heightMultiplierStackViewContainer).isActive = true
        stackViewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.lateralSpacingStackViewContainer).isActive = true
        stackViewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.lateralSpacingStackViewContainer).isActive = true
        stackViewContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        stackViewLabelsTop.heightAnchor.constraint(equalToConstant: self.view.frame.size.height*Constants.heightMultiplierStackViewChild).isActive = true
        stackViewLabelsMedium.heightAnchor.constraint(equalToConstant: self.view.frame.size.height*Constants.heightMultiplierStackViewChild).isActive = true
        stackViewLogos.heightAnchor.constraint(equalToConstant: self.view.frame.size.height*Constants.heightMultiplierStackViewChild).isActive = true

        stackViewContainer.addArrangedSubview(stackViewLabelsTop)
        stackViewContainer.addArrangedSubview(stackViewLabelsMedium)
        stackViewContainer.addArrangedSubview(stackViewLogos)
    }
    
    private func configureStackViewsLabels() {
        let labelTopTitle = self.getLabelTitleWithText("¿Quiénes somos?")
        let labelTopSubtitle = self.getLabelSubtitleWithText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
        let labelMiddleTitle = self.getLabelTitleWithText("¿Qué hacemos?")
        let labelMiddleSubtitle = self.getLabelSubtitleWithText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
        
        stackViewLabelsTop.addArrangedSubview(labelTopTitle)
        stackViewLabelsTop.addArrangedSubview(labelTopSubtitle)
        stackViewLabelsMedium.addArrangedSubview(labelMiddleTitle)
        stackViewLabelsMedium.addArrangedSubview(labelMiddleSubtitle)
    }
    
    private func configureStackViewIcons() {
        let arrayImageLogos = getArrayImagesLogos()
        for imageView in arrayImageLogos {
            stackViewLogos.addArrangedSubview(imageView)
        }
    }
    
    private func getLabelTitleWithText(_ text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.text = text
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 20.0)
        return label
    }
    
    private func getLabelSubtitleWithText(_ text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .white
        label.text = text
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 14.0)
        return label
    }
    
    private func getArrayImagesLogos() -> [UIImageView] {
        var arrayLogos = [UIImageView]()
        for nameLogo in arrayStringLogos {
            let image = UIImage(named: nameLogo)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            arrayLogos.append(imageView)
        }
        return arrayLogos
    }
    
    override func walkthroughDidScroll(to position: CGFloat, offset: CGFloat) {        
        var tr = CATransform3DIdentity
        tr.m34 = -1/1000.0
        view.layer.transform = CATransform3DRotate(tr, CGFloat(Double.pi*2)  * (1.0 - offset), 0.5,1, 0.2)
    }
}

