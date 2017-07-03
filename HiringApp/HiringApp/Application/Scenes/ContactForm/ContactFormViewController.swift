//
//  ContactFormViewController.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit

enum InputTextType {
    case name
    case surname
    case linkedin
    case address
    case phoneNumber
}

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
    
    let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 20.0
        stack.backgroundColor = .white
        stack.layoutMargins = UIEdgeInsets(top: 10.0, left: 0, bottom: 10.0, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    var nameTextField: UITextField!
    var surnameTextField: UITextField!
    var linkedInTextField: UITextField!
    var addressTextField: UITextField!
    var phoneTextField: UITextField!

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField = self.createTextField()
        surnameTextField = self.createTextField()
        linkedInTextField = self.createTextField()
        addressTextField = self.createTextField()
        phoneTextField = self.createTextField()
        nameTextField.tag = 0
        surnameTextField.tag = 1
        linkedInTextField.tag = 2
        addressTextField.tag = 3
        phoneTextField.tag = 4
        
        self.view.backgroundColor = .blue
        self.view.addSubview(titleLabel)
        
        self.addColoredViewToStackView(stackView: verticalStackView, color: .white)
        
        configureHorizontalStackView(field: "*Nombre", textField: nameTextField)
        configureHorizontalStackView(field: "*Apellidos", textField: surnameTextField)
        configureHorizontalStackView(field: "LinkedIn", textField: linkedInTextField, keyboardType: .URL)
        configureHorizontalStackView(field: "*Correo", textField: addressTextField, keyboardType: .emailAddress)
        configureHorizontalStackView(field: "*Teléfono", textField: phoneTextField, keyboardType: .numberPad)
        
        self.view.addSubview(sendButton)
        self.view.addSubview(verticalStackView)

        layout()
        presenter.viewDidLoad()
    }

    //MARK: - Private API
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.textColor = UIColor.lightGray
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.textAlignment = .left
        textField.text = "Type here..."
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }
    
    private func layout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let navigationBarHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 0.0
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30.0 + navigationBarHeight).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0).isActive = true
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 30.0).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 0.0).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: 0.0).isActive = true
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0).isActive = true
    }
    
    private func configureHorizontalStackView(field: String, textField: UITextField, keyboardType: UIKeyboardType = .default) {
        let horizontalStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 10.0
            stack.backgroundColor = .white
            return stack
        }()
        
        let formLabel: UILabel = {
            let lbl = UILabel()
            lbl.textColor = .black
            lbl.backgroundColor = .white
            lbl.text = field
            lbl.textAlignment = .center
            return lbl
        }()
        
        textField.keyboardType = keyboardType
        textField.autocorrectionType = .no
        
        horizontalStackView.addArrangedSubview(formLabel)
        horizontalStackView.addArrangedSubview(textField)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor).isActive = true
        
        formLabel.widthAnchor.constraint(equalTo: horizontalStackView.widthAnchor, multiplier: 0.25).isActive = true
        sendButton.addTarget(self, action: #selector(tappedSendButton), for: .touchUpInside)
    }
    
    private func addColoredViewToStackView(stackView: UIStackView, color: UIColor) {
        /*
         UIStackView is a non-drawing view, meaning that  drawRect() is never called and its background color is ignored.
         If you desperately want a background color, consider placing the stack view inside another UIView and giving
        that view a background color. 
         */
        
        let backgroundView = UIView(frame: stackView.bounds)
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.backgroundColor = color
        stackView.addSubview(backgroundView)
    }
}

extension ContactFormViewController: ContactFormUserInterfaceProtocol {
    
    func changeTextColorForTextField(textField: UITextField, color: UIColor) {
        textField.textColor = color
    }
    
    func emptyTextInTextField(textField: UITextField) {
        textField.text = ""
    }
    
    func restartTextFieldToDefault(textField: UITextField) {
        textField.text = "Type here..."
        textField.textColor = UIColor.lightGray
    }
}

//MARK: - User interaction

extension ContactFormViewController {
    func tappedSendButton() {
        presenter.tappedSendButton()
    }
}

extension ContactFormViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        var nextField: UITextField
        switch textField.tag {
        case 0:
            nextField = surnameTextField
        case 1:
            nextField = linkedInTextField
        case 2:
            nextField = addressTextField
        case 3:
            nextField = phoneTextField
        default:
            textField.resignFirstResponder()
            return false
        }
        nextField.becomeFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.textFieldDidBeginEditing(textField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        var field: InputTextType
        switch textField {
        case nameTextField:
            field = .name
            break
        case surnameTextField:
            field = .surname
            break
        case linkedInTextField:
            field = .linkedin
            break
        case addressTextField:
            field = .address
            break
        case phoneTextField:
            field = .phoneNumber
            break
        default:
            return
        }
        presenter.textFieldDidEndEditing(textField: textField, withText: text, forField: field)
    }
}
