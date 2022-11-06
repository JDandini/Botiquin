//
//  ColorPalette.swift
//  Botiquin
//
//  Created by Javier Castañeda on 05/11/22.
//

import UIKit

// MARK: - Hex String initializer
extension UIColor {
    convenience init?(hexString: String, alpha: CGFloat = 1) {
        let r, g, b: CGFloat
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    self.init(red: r, green: g, blue: b, alpha: alpha)
                    return
                }
            }
        }
        return nil
    }
}

// MARK: - Color palette
extension UIColor {
    class var mainGreen: UIColor {
        return UIColor(hexString: "#5588a3") ?? .black
    }

    class var anxiety: UIColor {
        return UIColor(hexString: "#2e4f8d") ?? .black
    }

    class var fear: UIColor {
        return UIColor(hexString: "#6a4603") ?? .black
    }

    class var sadness: UIColor {
        return UIColor(hexString: "#dc832e") ?? .black
    }

    class var anger: UIColor {
        return UIColor(hexString: "#a6b83d") ?? .black
    }

    class var frustration: UIColor {
        return UIColor(hexString: "#795697") ?? .black
    }

    class var loneliness: UIColor {
        return UIColor(hexString: "#e9b832") ?? .black
    }
}
