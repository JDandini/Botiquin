//
//  FilledValidation.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import Foundation
struct FilledValidation: Rulable {
    func validate(input: String?) -> Bool {
        guard let text = input else { return false }
        return !text.isEmpty
    }
}
