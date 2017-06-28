//
//  ContactFormViewController.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit

class ContactFormViewController: UIViewController {

    //MARK: - Stored properties
    var presenter: ContactFormPresenterProtocol!
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.backgroundColor = .blue
        lbl.text = "Si quieres aplicar para la posición de backend, déjanos tus datos y te contactamos en la mayor brevedad posible. Gracias!"
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    let horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    let formLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.backgroundColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        self.view.addSubview(titleLabel)
        layout()
        presenter.viewDidLoad()
    }

    //MARK: - Private API
    private func layout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let navigationBarHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 0.0
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30.0 + navigationBarHeight).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0).isActive = true
    }
}

extension ContactFormViewController: ContactFormUserInterfaceProtocol {
    
}
