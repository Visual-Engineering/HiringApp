//
//  AboutUsViewController.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 13/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    //MARK: - Stored properties
    var presenter: AboutUsPresenterProtocol!

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter.viewDidLoad()
    }

    //MARK: - Private API
    private func layout() {

    }
}

extension AboutUsViewController: AboutUsUserInterfaceProtocol {
    
}
