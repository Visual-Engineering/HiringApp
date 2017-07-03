//
//  WalkthroughPageThree.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit
import BWWalkthrough

class WalkthroughPageThreeViewController: BWWalkthroughPageViewController {
    
    var router: WalkthroughRouter?
    
    enum Constants {
        static let labelsTextColor: UIColor = .white
        
        static let heightStackView : CGFloat = 0.6
        static let stackViewSpacing: CGFloat = 20.0
        static let stackViewSidesMargin: CGFloat = 40.0
        
        static let topLabelFontSize: CGFloat = 20.0
        static let bottomLabelFontSize: CGFloat = 14.0
        static let labelsFontType: String = "Arial"
    }
    
    let labelTop : UILabel = {
        let label = UILabel()
        //MARK: TODO - Localize this string
        label.text = "¿Dónde estamos?"
        label.font = UIFont(name: Constants.labelsFontType, size: Constants.topLabelFontSize)
        label.numberOfLines = 1
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = Constants.labelsTextColor
        return label
    }()
    
    let imageMapView : UIImageView = {
        let image = UIImage(named: "map-screenshot")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let labelBottom : UILabel = {
        let label = UILabel()
        //MARK: TODO - Localize this string
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        label.font = UIFont(name: Constants.labelsFontType, size: Constants.bottomLabelFontSize)
        label.numberOfLines = 3
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = Constants.labelsTextColor
        return label
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        setup()
        layout()
        
        super.viewDidLoad()
    }
    
    //MARK: - Private API
    private func layout() {
        view.backgroundColor = .clear
    }
    
    private func setup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnMap))
        imageMapView.addGestureRecognizer(tapGesture)
        imageMapView.isUserInteractionEnabled = true
        
        view.addSubviewWithAutolayout(labelTop)
        view.addSubviewWithAutolayout(imageMapView)
        view.addSubviewWithAutolayout(labelBottom)

        labelTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * CGFloat(0.1)).isActive = true
        labelTop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * CGFloat(0.1))).isActive = true
        
        imageMapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * CGFloat(0.15)).isActive = true
        imageMapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * CGFloat(0.15))).isActive = true
        imageMapView.topAnchor.constraint(equalTo: labelTop.bottomAnchor, constant: 20).isActive = true
        imageMapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageMapView.heightAnchor.constraint(equalToConstant: view.frame.height * CGFloat(0.3)).isActive = true
        
        labelBottom.topAnchor.constraint(equalTo: imageMapView.bottomAnchor, constant: 20).isActive = true
        labelBottom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * CGFloat(0.1)).isActive = true
        labelBottom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * CGFloat(0.1))).isActive = true
    }
}

extension WalkthroughPageThreeViewController {
    func didTapOnMap() {
        router?.showModalMap()
    }
}