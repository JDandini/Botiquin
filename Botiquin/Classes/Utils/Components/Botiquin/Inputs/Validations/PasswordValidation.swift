//
//  PasswordValidation.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import Foundation

struct PasswordValidation: Rulable {

    private let regex: RegexType

    init(regex: RegexType) {
        self.regex = regex
    }

    func validate(input: String?) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex.rawValue)
        return predicate.evaluate(with: input)
    }
}
