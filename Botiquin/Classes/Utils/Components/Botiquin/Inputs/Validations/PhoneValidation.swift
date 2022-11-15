//
//  PhoneValidation.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import Foundation

struct PhoneValidation: Rulable {
    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        guard phoneNumber.count == 10 else { return false }
        let firstNumberIsValid = phoneNumber.first != "0"
        return firstNumberIsValid
    }

    func validate(input: String?) -> Bool {
        guard let phoneNumber = input else { return false }
        return isValidPhoneNumber(phoneNumber)
    }
}
