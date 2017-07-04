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

private enum Constants {
    
    // Colors
    static let brandBlue: UIColor =  UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
    static let highlightedButtonColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    static let titleLabelTextColor: UIColor = .white
    static let stackViewBackgroundColor: UIColor = .white
    static let formLabelTextColor: UIColor = .black
    
    // Text
    static let titleLabelText = "Si quieres aplicar para la posición de backend, déjanos tus datos y te contactamos en la mayor brevedad posible. ¡Gracias!"
    static let textFieldsPlaceholder = "Type here..."
    static let buttonText = "Enviar"
    
    // Constraints
    static let verticalStackViewVerticalInsets: CGFloat = 10.0
    static let verticalStackViewSpacing: CGFloat = 20.0
    static let verticalStackViewTopMargin: CGFloat = 20.0
    static let horizontalStackViewSpacing: CGFloat = 10.0
    static let horizontalStackViewSidesMargin: CGFloat = 10.0
    static let titleLabelSideMargin: CGFloat = 15.0
    static let titleLabelTopMargin: CGFloat = 20.0
    static let sendButtonTopMargin: CGFloat = 30.0
    static let sendButtonHeight: CGFloat = 30.0
    static let sendButtonWidthMultiplier: CGFloat = 0.5
    static let sendButtonCornerRadiusMultiplier: CGFloat = 0.5
    static let formLabelWidthMultiplier: CGFloat = 0.25
}

class ContactFormViewController: UIViewController {

    //MARK: - Stored properties
    var presenter: ContactFormPresenterProtocol!
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = Constants.titleLabelTextColor
        lbl.backgroundColor = Constants.brandBlue
        lbl.style = Style.title3
        lbl.styledText = Constants.titleLabelText
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = Constants.verticalStackViewSpacing
        stack.backgroundColor = Constants.stackViewBackgroundColor
        stack.layoutMargins = UIEdgeInsets(top: Constants.verticalStackViewVerticalInsets, left: 0, bottom: Constants.verticalStackViewVerticalInsets, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.style = Style.headline
        button.styledText = Constants.buttonText
        button.setStyledTitleColor(Constants.brandBlue)
        button.backgroundColor = Constants.stackViewBackgroundColor
        button.isEnabled = false
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
        
        self.view.backgroundColor = Constants.brandBlue
        self.view.addSubview(titleLabel)
        
        self.addColoredViewToStackView(stackView: verticalStackView, color: Constants.stackViewBackgroundColor)
        
        configureHorizontalStackView(field: "Nombre *", textField: nameTextField)
        configureHorizontalStackView(field: "Apellidos *", textField: surnameTextField)
        configureHorizontalStackView(field: "LinkedIn", textField: linkedInTextField, keyboardType: .URL)
        configureHorizontalStackView(field: "Correo *", textField: addressTextField, keyboardType: .emailAddress)
        configureHorizontalStackView(field: "Teléfono *", textField: phoneTextField, keyboardType: .numberPad)
        
        self.view.addSubview(sendButton)
        self.view.addSubview(verticalStackView)

        layout()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        sendButton.layer.cornerRadius = sendButton.frame.size.height * Constants.sendButtonCornerRadiusMultiplier
    }

    //MARK: - Private API
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = Constants.stackViewBackgroundColor
        textField.textAlignment = .left
        textField.style = .body
        textField.placeholder = Constants.textFieldsPlaceholder
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }
    
    private func layout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: Constants.titleLabelTopMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLabelSideMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.titleLabelSideMargin).isActive = true
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: Constants.sendButtonTopMargin).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: Constants.sendButtonHeight).isActive = true
        sendButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.sendButtonWidthMultiplier).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.verticalStackViewTopMargin).isActive = true
        
    }
    
    private func configureHorizontalStackView(field: String, textField: UITextField, keyboardType: UIKeyboardType = .default) {
        let horizontalStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = Constants.horizontalStackViewSpacing
            stack.backgroundColor = Constants.stackViewBackgroundColor
            return stack
        }()
        
        let formLabel: UILabel = {
            let lbl = UILabel()
            lbl.textColor = Constants.formLabelTextColor
            lbl.backgroundColor = Constants.stackViewBackgroundColor
            lbl.styledText = field
            lbl.textAlignment = .left
            lbl.style = Style.body
            return lbl
        }()
        
        textField.keyboardType = keyboardType
        textField.autocorrectionType = .no
        
        horizontalStackView.addArrangedSubview(formLabel)
        horizontalStackView.addArrangedSubview(textField)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: Constants.horizontalStackViewSidesMargin).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: Constants.horizontalStackViewSidesMargin).isActive = true
        
        formLabel.widthAnchor.constraint(equalTo: horizontalStackView.widthAnchor, multiplier: Constants.formLabelWidthMultiplier).isActive = true
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
        
    func setButtonState(enabled: Bool) {
        sendButton.isEnabled = enabled
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
