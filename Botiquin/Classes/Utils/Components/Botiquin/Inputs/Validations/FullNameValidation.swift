//
//  FullNameValidation.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import Foundation

struct NameValidation: Rulable {
    enum NameType {
        case full
    }

    init(type: NameType) {
        self.type = type
    }

    let type: NameType

    private func isValidFullName(_ fullname: String) -> Bool {
        guard !fullname.isEmpty else {
            return  false
        }
        let substrings = fullname.trim().split(separator: " ")
        return substrings.count > 1
    }

    func validate(input: String?) -> Bool {
        guard let fullName = input else { return false }
        switch type {
        case .full:
            return isValidFullName(fullName)
        }
    }
}
