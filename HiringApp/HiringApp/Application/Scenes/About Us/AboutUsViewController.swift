//
//  AboutUsViewController.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 13/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit
import WebKit

class AboutUsViewController: UIViewController {

    //MARK: - Stored properties
    var presenter: AboutUsPresenterProtocol!
    
    let webView = WKWebView()

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter.viewDidLoad()
        setup()
    }

    //MARK: - Private API
    private func layout() {
        view.addSubviewWithAutolayout(webView)
        webView.fillSuperview()
    }
    
    private func setup() {
        //MARK: TO-DO Localize this string
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissMapController))
        
        let url = URL(string: "http://visual-engin.com")
        guard let urlString = url else { return }
        
        let request = URLRequest(url: urlString)
        webView.load(request)
    }
    
    func dismissMapController() {
        dismiss(animated: true)
    }
}

extension AboutUsViewController: AboutUsUserInterfaceProtocol {
    
}
