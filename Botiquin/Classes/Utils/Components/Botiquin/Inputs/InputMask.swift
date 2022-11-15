//
//  InputMask.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import Foundation

enum InputMask {
    case postalCode
    case phone
    case amex
    case creditCard
    case cvv
    case expirationDate
    case custom(mask: String)

    var mask: String {
        switch self {
        case .postalCode:
            return "{ddddd}"
        case .phone:
            return "{dddddddddd}"
        case .amex:
            return "{dddd} {dddddd} {dddddd}"
        case .creditCard:
            return "{dddd} {dddd} {dddd} {dddd}"
        case .cvv:
            return "{dddd}"
        case .expirationDate:
            return "{dd}/{dd}"
        case .custom(let mask):
            return mask
        }
    }
}
