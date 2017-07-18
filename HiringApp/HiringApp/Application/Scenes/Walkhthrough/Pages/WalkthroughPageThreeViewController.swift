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
    
    weak var delegate: WalkthoughViewControllerDelegate?
    
    enum Constants {
        static let labelsTextColor: UIColor = .white
        
        static let heightStackView: CGFloat = 0.6
        static let stackViewSpacing: CGFloat = 20.0
        static let stackViewSidesMargin: CGFloat = 40.0
        
        static let topLabelFontSize: CGFloat = 20.0
        static let bottomLabelFontSize: CGFloat = 14.0
        static let labelsFontType: String = "Arial"
    }
    
    let labelTop: UILabel = {
        let label = UILabel()
        LabelHelper.Walkthrough.setup(label: label, type: .title, text: R.string.localizable.walkthrough_title3())
        return label
    }()
    
    let imageMapView: UIImageView = {
        let image = R.image.mapScreenshot()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let labelBottom: UILabel = {
        let label = UILabel()
        LabelHelper.Walkthrough.setup(label: label, type: .subtitle, text: R.string.localizable.walkthrough_subtitles3())
        return label
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        setupWalkthroughTransitionValues()
        setup()
        layout()
        
        super.viewDidLoad()
    }
        
    //MARK: - Private API
    private func layout() {
        view.backgroundColor = .clear
    }
    
    private func setupWalkthroughTransitionValues() {
        let speed = CGPoint(x: 0.1, y: 0)
        let speedVariance = CGPoint(x:3, y: 0)
        let animationType = "Linear"
        let animateAlpha = true
        
        self.setValue(speed, forKey: "speed")
        self.setValue(speedVariance, forKey: "speedVariance")
        self.setValue(animationType, forKey: "animationType")
        self.setValue(animateAlpha, forKey: "animateAlpha")
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
        if let delegate = delegate {
            guard let containerViewController = delegate as? WalkthroughViewController else { return }
            //If it's not hidden, after map dismiss, there is a delay when updating the exact page of the pageControl, so we hide it until its currentPage is updated
            containerViewController.pageControl?.isHidden = true
        }
        delegate?.didClickOnMap()
    }
}


