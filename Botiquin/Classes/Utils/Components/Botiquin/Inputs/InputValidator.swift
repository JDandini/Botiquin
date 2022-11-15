//
//  InputValidator.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import Foundation

enum InputValidationType: String {
    case email
    case password
    case fullname
    case phone
    case filled
    case none
}

protocol InputValidation {
    var isValid: Bool { get }

    var validationText: String? { get }
    var trimmedValidationText: String? { get }
    var validationType: InputValidationType { get set }

    var customErrorMessage: String? { get set }

    func validate() -> String?
    func handleError(withMessage message: String)
    func handleSuccess()
}

extension InputValidation {
    var trimmedValidationText: String? { validationText?.trim() }
}

extension InputValidation where Self: Any {
    var isValid: Bool {
        switch validationType {
        case .email:
            return EmailValidation(regex: .email).validate(input: trimmedValidationText)
        case .password:
            return PasswordValidation(regex: .password).validate(input: validationText)
        case .fullname:
            return NameValidation(type: .full).validate(input: validationText)
        case .phone:
            return PhoneValidation().validate(input: validationText)
        case .filled:
            return FilledValidation().validate(input: validationText)
        default:
            return true
        }
    }

    func isValidContent() -> Bool {
        let message = errorMessage(for: validationType) ?? ""
        isValid ? handleSuccess() : handleError(withMessage: message)
        return isValid
    }

    func validate() -> String? {
        let message: String?

        if let customMessage = customErrorMessage {
            message = customMessage

        } else {
            message = errorMessage(for: validationType)
        }

        if isValid {
            handleSuccess()
            return .none
        } else {
            handleError(withMessage: message ?? "")
            return message
        }
    }

    private func errorMessage(for type: InputValidationType) -> String? {
        var message: String?

        switch validationType {
        case .email: message = "Email invalido"
        case .password: message = "Password invalido"
        case .fullname: message = "Debes poner tu nombre completo"
        case .phone: message = "Telefono invalido"
        case .filled: message = "Campo requerido"
        case .none: message = .none
        }

        return message
    }
}
