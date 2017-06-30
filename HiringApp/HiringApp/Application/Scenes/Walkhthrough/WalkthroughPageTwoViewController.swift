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
    
    var labelMiddleSubtitle = UILabel()
    
    enum Constants {
        static let labelsTextColor: UIColor = .white
        
        static let topMarginMultiplierStackViewContainer: CGFloat = 0.05
        static let heightMultiplierStackViewContainer: CGFloat = 0.6
        static let lateralSpacingStackViewContainer: CGFloat = 40
        
        static let labelsFontType: String = "Arial"
        static let titleLabelsFontSize: CGFloat = 20.0
        static let subtitleLabelsFontSize: CGFloat = 14.0
    }
    
    private let arrayStringLogos = ["apple-logo","android-logo","windowsp-logo","js-logo"]
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        configureLabels()
        configureIcons()
        layout()
        
        super.viewDidLoad()
    }

    //MARK: - Private API
    private func layout() {
        view.backgroundColor = .clear
        
        edgesForExtendedLayout = []
        
    }
    
    private func configureLabels() {
        let labelTopTitle = self.getLabelTitleWithText("¿Quiénes somos?")
        view.addSubviewWithAutolayout(labelTopTitle)

        labelTopTitle.topAnchor.constraint(equalTo: view.topAnchor, constant:self.view.frame.height * CGFloat(0.2)).isActive = true
        labelTopTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * CGFloat(0.1)).isActive = true
        labelTopTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * CGFloat(0.1))).isActive = true

        let labelTopSubtitle = self.getLabelSubtitleWithText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
        view.addSubviewWithAutolayout(labelTopSubtitle)

        labelTopSubtitle.topAnchor.constraint(equalTo: labelTopTitle.bottomAnchor, constant: 20).isActive = true
        labelTopSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * CGFloat(0.1)).isActive = true
        labelTopSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * CGFloat(0.1))).isActive = true

        let labelMiddleTitle = self.getLabelTitleWithText("¿Qué hacemos?")
        view.addSubviewWithAutolayout(labelMiddleTitle)

        labelMiddleTitle.topAnchor.constraint(equalTo: labelTopSubtitle.bottomAnchor, constant: 20).isActive = true
        labelMiddleTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * CGFloat(0.1)).isActive = true
        labelMiddleTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * CGFloat(0.1))).isActive = true
        
        labelMiddleSubtitle = self.getLabelSubtitleWithText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
        view.addSubviewWithAutolayout(labelMiddleSubtitle)

        labelMiddleSubtitle.topAnchor.constraint(equalTo: labelMiddleTitle.bottomAnchor, constant: 20).isActive = true
        labelMiddleSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * CGFloat(0.1)).isActive = true
        labelMiddleSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * CGFloat(0.1))).isActive = true
    }
    
    private func configureIcons() {
        let arrayImageLogos = getArrayImagesLogos()
        
        for (index,imageView) in arrayImageLogos.enumerated() {
            view.addSubviewWithAutolayout(imageView)
            
            var leadingAnchor = NSLayoutXAxisAnchor()
            var previousImage = UIImageView()
            if index > 0 {
                previousImage = arrayImageLogos[index-1]
            }
            let previousLeadingAnchor = previousImage.leadingAnchor

            leadingAnchor = (index == 0) ? view.leadingAnchor : previousLeadingAnchor
            let constant = (index == 0) ? view.frame.width * CGFloat(0.1) : imageView.frame.width + view.frame.width * CGFloat(0.1)

            if index > 0 {
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant).isActive = true
            }
            if index == 1 {
                imageView.trailingAnchor.constraint(equalTo: labelMiddleSubtitle.centerXAnchor).isActive = true
            }
            imageView.topAnchor.constraint(equalTo: labelMiddleSubtitle.bottomAnchor, constant: 20).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.17).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: self.view.frame.width * 0.17).isActive = true
        }
    }
    
    private func getLabelTitleWithText(_ text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = Constants.labelsTextColor
        label.text = text
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont(name: Constants.labelsFontType, size: Constants.titleLabelsFontSize)
        return label
    }
    
    private func getLabelSubtitleWithText(_ text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = Constants.labelsTextColor
        label.text = text
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont(name: Constants.labelsFontType, size: Constants.subtitleLabelsFontSize)
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
}
