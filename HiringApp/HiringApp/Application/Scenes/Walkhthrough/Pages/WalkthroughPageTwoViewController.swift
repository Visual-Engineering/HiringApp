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
        setupWalkthroughTransitionValues()
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
    
    private func setupWalkthroughTransitionValues(){
        let speed = CGPoint(x: 0.1, y: 0)
        let speedVariance = CGPoint(x:3, y: 0)
        let animationType = "Linear"
        let animateAlpha = true
        
        self.setValue(speed, forKey: "speed")
        self.setValue(speedVariance, forKey: "speedVariance")
        self.setValue(animationType, forKey: "animationType")
        self.setValue(animateAlpha, forKey: "animateAlpha")
    }
    
    private func configureLabels() {
        let labelTopTitle = UILabel()
        LabelHelper.Walkthrough.setup(label: labelTopTitle, type: .title, text: R.string.localizable.walkthrough_title1())
        view.addSubviewWithAutolayout(labelTopTitle)

        labelTopTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * CGFloat(0.1)).isActive = true
        labelTopTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * CGFloat(0.1))).isActive = true

        //MARK: TODO - Localize this string
        let labelTopSubtitle = UILabel()
        LabelHelper.Walkthrough.setup(label: labelTopSubtitle, type: .subtitle, text: R.string.localizable.walkthrough_subtitles1())
        view.addSubviewWithAutolayout(labelTopSubtitle)

        labelTopSubtitle.topAnchor.constraint(equalTo: labelTopTitle.bottomAnchor, constant: 20).isActive = true
        labelTopSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * CGFloat(0.1)).isActive = true
        labelTopSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * CGFloat(0.1))).isActive = true

        //MARK: TODO - Localize this string
        let labelMiddleTitle = UILabel()
        LabelHelper.Walkthrough.setup(label: labelMiddleTitle, type: .title, text: R.string.localizable.walkthrough_title2())
        view.addSubviewWithAutolayout(labelMiddleTitle)

        labelMiddleTitle.topAnchor.constraint(equalTo: labelTopSubtitle.bottomAnchor, constant: 20).isActive = true
        labelMiddleTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * CGFloat(0.1)).isActive = true
        labelMiddleTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * CGFloat(0.1))).isActive = true
        labelMiddleTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        //MARK: TODO - Localize this string
        labelMiddleSubtitle = UILabel()
        LabelHelper.Walkthrough.setup(label: labelMiddleSubtitle, type: .subtitle, text: R.string.localizable.walkthrough_subtitles2())

        view.addSubviewWithAutolayout(labelMiddleSubtitle)

        labelMiddleSubtitle.topAnchor.constraint(equalTo: labelMiddleTitle.bottomAnchor, constant: 20).isActive = true
        labelMiddleSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * CGFloat(0.1)).isActive = true
        labelMiddleSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * CGFloat(0.1))).isActive = true
    }
    
    private func configureIcons() {
        let arrayImageLogos = createArrayImagesLogos()
        
        for (index,logo) in arrayImageLogos.enumerated() {
            view.addSubviewWithAutolayout(logo)
            
            var previousImageShown = UIImageView()
            if index > 0 {
                previousImageShown = arrayImageLogos[index-1]
            }
            
            let previousLeadingAnchor = previousImageShown.leadingAnchor
            var leadingAnchorParentView = NSLayoutXAxisAnchor()
            leadingAnchorParentView = (index == 0) ? view.leadingAnchor : previousLeadingAnchor
            
            let constantLeadingAnchor = (index == 0) ? view.frame.width * CGFloat(0.1) : logo.frame.width + view.frame.width * CGFloat(0.1)

            addLogoConstraints(logo: logo, index: index, constantLeadingAnchor: constantLeadingAnchor, leadingAnchor: leadingAnchorParentView)
        }
    }
    
    private func addLogoConstraints(logo: UIImageView, index: Int, constantLeadingAnchor: CGFloat, leadingAnchor: NSLayoutXAxisAnchor){
        if index > 0 {
            logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constantLeadingAnchor).isActive = true
            if index == 1 {
                logo.trailingAnchor.constraint(equalTo: labelMiddleSubtitle.centerXAnchor).isActive = true
            }
        }
        logo.topAnchor.constraint(equalTo: labelMiddleSubtitle.bottomAnchor, constant: 20).isActive = true
        logo.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.17).isActive = true
        logo.heightAnchor.constraint(equalToConstant: self.view.frame.width * 0.17).isActive = true
    }

    private func createArrayImagesLogos() -> [UIImageView] {
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
