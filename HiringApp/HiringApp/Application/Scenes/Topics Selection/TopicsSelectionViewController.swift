//
//  TopicsSelectionViewController.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 12/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit

class TopicsSelectionViewController: UIViewController {

    //MARK: - Stored properties
    var presenter: TopicsSelectionPresenterProtocol!

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

extension TopicsSelectionViewController: TopicsSelectionUserInterfaceProtocol {
    
}
