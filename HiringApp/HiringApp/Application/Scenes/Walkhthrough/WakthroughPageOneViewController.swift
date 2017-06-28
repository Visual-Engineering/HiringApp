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
        
    enum Constants {
        static let blueBackground : UIColor = UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
    }
    
    let imageView : UIImageView = {
        let image = UIImage(named: "visual-engin-logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tag = 256
        return imageView
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        layout()
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
    
    override func walkthroughDidScroll(to position: CGFloat, offset: CGFloat) {
        var tr = CATransform3DIdentity
        tr.m34 = -1/1000.0
        view.layer.transform = CATransform3DRotate(tr, CGFloat(Double.pi)  * (1.0 - offset), 0.5,1, 0.2)
    }
}
