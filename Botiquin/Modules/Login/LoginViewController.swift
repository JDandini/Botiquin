//
//  LoginViewController.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import UIKit

final class LoginViewController: UIViewController {
    struct Metrics {
        static let offset: CGFloat = 40
        static let minOffset: CGFloat = 10
        static let textfieldHeight: CGFloat = 50
        static let buttonHeight: CGFloat = 50
        static let footerHeight: CGFloat = 60
    }

    private var requiredFields: [FloatLabelTextField] = []

    private let imageView: UIImageView = {
        let image = UIImage(named: "first-aid-kit")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let emailTextField: FloatLabelTextField  = {
        let textfield = FloatLabelTextField(frame: .zero)
        textfield.placeholder = "Usuario"
        textfield.placeHolderColor = .darkGray
        textfield.validationType = .filled
        textfield.textColor = .black
        textfield.font = .paragraph
        textfield.baselineNormalColor = .gray
        textfield.baselineHeight = 2
        textfield.keyboardType = .emailAddress
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    private let passwordTextField: FloatLabelTextField  = {
        let textfield = FloatLabelTextField(frame: .zero)
        textfield.placeholder = "Contraseña"
        textfield.placeHolderColor = .darkGray
        textfield.validationType = .filled
        textfield.showSecretEye = true
        textfield.baselineNormalColor = .gray
        textfield.baselineHeight = 2
        textfield.font = .paragraph
        textfield.textColor = .black
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("¿Olvidaste tu contraseña?", for: .normal)
        button.titleLabel?.font = .link
        return button
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .mainGreen
        button.titleLabel?.font = .button
        button.tintColor = .white
        button.setTitle("Iniciar", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didPressLoginButton), for: .touchUpInside)
        return button
    }()

    private let footerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mainGreen
        return view
    }()

    var presenter: LoginPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(footerView)
        requiredFields = [emailTextField, passwordTextField]
        requiredFields.forEach { $0.delegate = self }
    }

    private func setupConstraints() {
        view.addConstraints([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metrics.offset / 2),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.offset),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.offset),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),

            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.offset),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.offset),
            emailTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Metrics.minOffset),
            emailTextField.heightAnchor.constraint(equalToConstant: Metrics.textfieldHeight),

            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.offset),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.offset),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Metrics.minOffset * 3),
            passwordTextField.heightAnchor.constraint(equalToConstant: Metrics.textfieldHeight),

            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.offset),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.offset),
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Metrics.offset / 2),

            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.offset),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.offset),
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: Metrics.offset),
            loginButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight),

            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: Metrics.footerHeight)
        ])
    }

    @objc private func didPressLoginButton() {
        let isValid = requiredFields.allSatisfy { $0.isValidContent() }
        guard isValid else { return }
        presenter?.didPressLoginButton()
    }
}

extension LoginViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField,
                              reason: UITextField.DidEndEditingReason) {
    textField.text = textField.text?.trim()
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case emailTextField:
      passwordTextField.becomeFirstResponder()
    case passwordTextField:
      textField.resignFirstResponder()
        self.didPressLoginButton()
    default:
      break
    }
    return true
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
    guard let field = textField as? FloatLabelTextField else {
      return
    }
    field.hideError(animated: true)
  }
}

extension LoginViewController: LoginViewProtocol { }
