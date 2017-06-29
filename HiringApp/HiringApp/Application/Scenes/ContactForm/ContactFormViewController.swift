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
    
    let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    let formLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.backgroundColor = .white
        lbl.text = "Nombre: "
        lbl.textAlignment = .center
        return lbl
    }()
    
    let textField: UITextField = {
       let textField = UITextField()
        textField.textColor = UIColor.lightGray
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.textAlignment = .left
        textField.text = "Type here..."
        return textField
    }()

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        self.view.addSubview(titleLabel)
        
        let formFieldNames: [String] = ["Nombre", "Apellidos", "LinkedIn", "Correo", "Teléfono"]
        for field in formFieldNames {
            verticalStackView.addArrangedSubview(horizontalStackView)
            formLabel.text = field
            horizontalStackView.addArrangedSubview(formLabel)
            horizontalStackView.addArrangedSubview(textField)
        }
        
        
        
        self.view.addSubview(verticalStackView)
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
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        
        formLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    private func configureLabel() {
    
    }
}

extension ContactFormViewController: ContactFormUserInterfaceProtocol {
    
}
