//
//  ContactFormViewController.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import UIKit

enum InputTextType: Int {
    case name = 0
    case surname
    case linkedin
    case address
    case phoneNumber
}

enum TextViewInputState {
    case correct
    case incorrect
}

private enum Constants {
    
    // Colors
    static let brandBlue: UIColor =  UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
    static let highlightedButtonColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    static let titleLabelTextColor: UIColor = .white
    static let stackViewBackgroundColor: UIColor = .white
    static let formLabelTextColor: UIColor = .black
    static let wrongInputColor: UIColor = .red
    static let correctInputColor: UIColor = .darkGray
    
    // Text
    static let titleLabelText = R.string.localizable.cf_title()
    static let textFieldsPlaceholder = R.string.localizable.cf_placeholder()
    static let buttonText = R.string.localizable.cf_send()
    
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
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        return indicator
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
        nameTextField.tag = InputTextType.name.rawValue
        surnameTextField.tag = InputTextType.surname.rawValue
        linkedInTextField.tag = InputTextType.linkedin.rawValue
        addressTextField.tag = InputTextType.address.rawValue
        phoneTextField.tag = InputTextType.phoneNumber.rawValue
        
        self.view.backgroundColor = Constants.brandBlue
        self.view.addSubview(titleLabel)
        
        self.addColoredViewToStackView(stackView: verticalStackView, color: Constants.stackViewBackgroundColor)
        
        configureHorizontalStackView(field: R.string.localizable.cf_name(), textField: nameTextField)
        configureHorizontalStackView(field: R.string.localizable.cf_lastname(), textField: surnameTextField)
        configureHorizontalStackView(field: R.string.localizable.cf_linkedin(), textField: linkedInTextField, keyboardType: .URL)
        configureHorizontalStackView(field: R.string.localizable.cf_email(), textField: addressTextField, keyboardType: .emailAddress)
        configureHorizontalStackView(field: R.string.localizable.cf_phone(), textField: phoneTextField, keyboardType: .numberPad)
        
        self.view.addSubview(sendButton)
        self.view.addSubview(verticalStackView)

        // layout activity indicator
        view.addSubview(activityIndicator)
        activityIndicator.bringSubview(toFront: view)
        activityIndicator.center = view.center

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
        textField.textColor = Constants.correctInputColor
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
    
    func setTextViewColor(forField field: InputTextType, withState state: TextViewInputState) {
        
        guard let textField = view.viewWithTag(field.rawValue) as? UITextField else {
            return
        }
        
        textField.textColor = state == .correct ? Constants.correctInputColor : Constants.wrongInputColor
    }
    
    func setButtonState(enabled: Bool) {
        sendButton.isEnabled = enabled
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
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
        
        guard let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField else {
            textField.resignFirstResponder()
            return false
        }
        nextTextField.becomeFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let fieldInputType = InputTextType(rawValue: textField.tag) else {
            return
        }
        presenter.textFieldDidBeginEditing(field: fieldInputType)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else {
            return
        }
        
        guard let fieldInputType = InputTextType(rawValue: textField.tag) else {
            return
        }
        presenter.textFieldDidEndEditing(withText: text, forField: fieldInputType)
    }
}
