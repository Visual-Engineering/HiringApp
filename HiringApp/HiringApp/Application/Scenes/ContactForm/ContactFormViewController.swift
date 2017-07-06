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
        lbl.styledText = R.string.localizable.cf_title()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.stackViewBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    lazy var sendButton: RoundedButton = {
        let button = RoundedButton()
        button.style = Style.headline
        button.styledText = R.string.localizable.cf_send()
        button.setStyledTitleColor(Constants.brandBlue)
        button.backgroundColor = Constants.stackViewBackgroundColor
        button.isEnabled = false
        button.addTarget(self, action: #selector(tappedSendButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    var nameTextField: UITextField!
    var surnameTextField: UITextField!
    var linkedInTextField: UITextField!
    var addressTextField: UITextField!
    var phoneTextField: UITextField!
    
    
    private var textFields: [(UITextField, String)] {
        return [
            (nameTextField, R.string.localizable.cf_name()),
            (surnameTextField, R.string.localizable.cf_lastname()),
            (linkedInTextField, R.string.localizable.cf_linkedin()),
            (addressTextField, R.string.localizable.cf_email()),
            (phoneTextField, R.string.localizable.cf_phone())
        ]
    }

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Constants.brandBlue
        
        createFields()
        layout()
        
        presenter.viewDidLoad()
    }
    
    //MARK: - Private API
    
    private func createFields() {
        nameTextField = UITextField(withInput: .name, delegate: self)
        surnameTextField = UITextField(withInput: .surname, delegate: self)
        linkedInTextField = UITextField(withInput: .linkedin, keyboardType: .URL, delegate: self)
        addressTextField = UITextField(withInput: .address, keyboardType: .emailAddress, delegate: self)
        phoneTextField = UITextField(withInput: .phoneNumber, keyboardType: .numberPad, delegate: self)
        
        textFields.forEach { (field, label) in
            let view = UIStackView(embeddingField: field, withLabel: label)
            verticalStackView.addArrangedSubview(view)
        }
    }
    
    private func layout() {
        
        //View hierarchy
        
        view.addSubview(titleLabel)
        view.addSubview(containerView)
        view.addSubview(sendButton)
        
        view.addSubview(activityIndicator)
        
        
        containerView.addSubview(verticalStackView)
        verticalStackView.fillSuperview()
        
        
        // Constraints
        
        //Title Layout
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: topLayoutGuide.bottomAnchor,
                constant: Constants.titleLabelTopMargin),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.titleLabelSideMargin),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.titleLabelSideMargin)
            ])
        
        //Container Layout
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.verticalStackViewTopMargin)
            ])
    
        // Button Layout
        // Align bottom with constant. Half Width as the screen, fixed height
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: Constants.sendButtonTopMargin),
            sendButton.heightAnchor.constraint(
                equalToConstant: Constants.sendButtonHeight),
            sendButton.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: Constants.sendButtonWidthMultiplier),
            sendButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
            ])
        
        // layout activity indicator
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
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
    
    func showErrorAlert() {
        showAlert(baseView: self, title: R.string.localizable.error(), message: R.string.localizable.error_message())
    }
}

//MARK: - User interaction

extension ContactFormViewController {
    func tappedSendButton() {
        presenter.tappedSendButton()
    }
}

extension ContactFormViewController: UITextFieldDelegate {
    
    private func inputTextField(fromTextField textField: UITextField) -> InputTextType {
        switch textField {
        case nameTextField:
            return .name
        case surnameTextField:
            return .surname
        case linkedInTextField:
            return .linkedin
        case addressTextField:
            return .address
        case phoneTextField:
            return .phoneNumber
        default:
            fatalError()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField else {
            textField.resignFirstResponder()
            return false
        }
        nextTextField.becomeFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.textFieldDidBeginEditing(field: inputTextField(fromTextField: textField))
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

extension UITextField {
    convenience init(withInput inputTextType: InputTextType, keyboardType: UIKeyboardType = .default, delegate: UITextFieldDelegate?) {
        self.init(frame: .zero)
        
        self.backgroundColor = Constants.stackViewBackgroundColor
        self.textAlignment = .left
        self.style = .body
        self.placeholder = R.string.localizable.cf_placeholder()
        self.textColor = Constants.correctInputColor
        self.delegate = delegate
        self.returnKeyType = .done
        self.tag = inputTextType.rawValue
        self.keyboardType = keyboardType
        self.autocorrectionType = .no
    }

}

extension UIStackView {
    fileprivate convenience init(embeddingField textField: UITextField, withLabel label: String) {
        self.init()
        axis = .horizontal
        distribution = .fill
        spacing = Constants.horizontalStackViewSpacing
        backgroundColor = Constants.stackViewBackgroundColor
        
        let formLabel: UILabel = {
            let lbl = UILabel()
            lbl.textColor = Constants.formLabelTextColor
            lbl.backgroundColor = Constants.stackViewBackgroundColor
            lbl.styledText = label
            lbl.textAlignment = .left
            lbl.style = Style.body
            return lbl
        }()
        
        addArrangedSubview(formLabel)
        addArrangedSubview(textField)
        
        NSLayoutConstraint.activate([
            formLabel.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: Constants.formLabelWidthMultiplier),
            formLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.horizontalStackViewSidesMargin)
            ])
        
    }
}
