//
//  WalkthroughContainerViewController.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 28/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit
import BWWalkthrough

class WalkthroughContainerViewController: BWWalkthroughViewController {
    
    enum Constants {
        static let blueBackground : UIColor = UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
    }
        
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.blueBackground
    }
}

