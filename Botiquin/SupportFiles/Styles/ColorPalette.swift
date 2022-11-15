//
//  ColorPalette.swift
//  Botiquin
//
//  Created by Javier Castañeda on 05/11/22.
//

import UIKit

// MARK: - Hex String initializer
extension UIColor {

    convenience init?(hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        guard cString.count != 6 else { return nil }

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )

    }
}

// MARK: - Color palette
extension UIColor {
    class var mainGreen: UIColor {
        return UIColor(hex: "#5588a3") ?? .black
    }

    class var anxiety: UIColor {
        return UIColor(hex: "#2e4f8d") ?? .black
    }

    class var fear: UIColor {
        return UIColor(hex: "#6a4603") ?? .black
    }

    class var sadness: UIColor {
        return UIColor(hex: "#dc832e") ?? .black
    }

    class var anger: UIColor {
        return UIColor(hex: "#a6b83d") ?? .black
    }

    class var frustration: UIColor {
        return UIColor(hex: "#795697") ?? .black
    }

    class var loneliness: UIColor {
        return UIColor(hex: "#e9b832") ?? .black
    }
}
