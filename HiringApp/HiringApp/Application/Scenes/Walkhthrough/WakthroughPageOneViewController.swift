//
//  WakthroughPageOne.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit
import BWWalkthrough

class WalkthroughPageOneViewController: BWWalkthroughPageViewController {
        
    let imageView : UIImageView = {
        let image = UIImage(named: "visual-engin-logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        layout()

        super.viewDidLoad()
    }
    
    //MARK: - Private API
    private func layout() {
        view.backgroundColor = .clear
        
        view.addSubviewWithAutolayout(imageView)
        
        imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width*CGFloat(0.8)).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.size.height*CGFloat(0.4)).isActive = true

        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

