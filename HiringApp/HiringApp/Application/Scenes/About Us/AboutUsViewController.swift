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

    // MARK: - Stored properties
    var presenter: AboutUsPresenterProtocol!
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.activityIndicatorViewStyle = .gray
        return activityIndicatorView
    }()
    
    let webView = WKWebView()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter.viewDidLoad()
        setup()
    }

    // MARK: - Private API
    private func layout() {
        webView.addSubviewWithAutolayout(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: webView.centerYAnchor).isActive = true
        
        view.addSubviewWithAutolayout(webView)
        webView.fillSuperview()
    }
    
    private func setup() {
        webView.navigationDelegate = self
        edgesForExtendedLayout = []
        // MARK: TO-DO Localize this string
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissMapController))
        
        activityIndicatorView.startAnimating()
        
        makeWebviewRequest()
    }
    
    func dismissMapController() {
        dismiss(animated: true)
    }
    
    func makeWebviewRequest() {
        let url = URL(string: "http://visual-engin.com")
        guard let urlString = url else { return }
        
        let request = URLRequest(url: urlString)
        webView.load(request)
    }
}

extension AboutUsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
    }
}

extension AboutUsViewController: AboutUsUserInterfaceProtocol {
    
}
