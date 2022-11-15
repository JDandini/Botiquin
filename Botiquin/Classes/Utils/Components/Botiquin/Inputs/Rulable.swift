//
//  Rulable.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import Foundation

protocol Rulable {
    func validate(input: String?) -> Bool
}
