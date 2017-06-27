//
//  WakthroughPageOne.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

class WalkthroughPageOneViewController: UIViewController {
        
    enum Constants {
        static let blueBackground : UIColor = UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
    }
    
    let imageView : UIImageView = {
        let image = UIImage(named: "visual-engin-logo")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    
    }
    
    //MARK: - Private API
    private func layout() {
        view.backgroundColor = Constants.blueBackground
        
        view.addSubviewWithAutolayout(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
