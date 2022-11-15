//
//  UIImageExtensions.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import UIKit

enum ImageSize {
    case navigation
    case titleView
    case tabBar
    case colorPicker
    case addItem
    case deletion

    var size: CGSize {
        switch self {
        case .navigation:
            return CGSize(width: 24, height: 24)
        case .titleView:
            return CGSize(width: 60, height: 20)
        case .tabBar:
            return CGSize(width: 32, height: 32)
        case .colorPicker:
            return CGSize(width: 20, height: 20)
        case .addItem:
            return CGSize(width: 14, height: 14)
        case .deletion:
            return CGSize(width: 35, height: 35)
        }
    }
}

extension UIImage {
    func resizeImage(sizeChange: CGSize = ImageSize.navigation.size) -> UIImage {
        let hasAlpha = true
        let scale: CGFloat = UIScreen.main.scale // Use scale factor of main screen
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        draw(in: CGRect(origin: .zero, size: sizeChange))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return (scaledImage ?? self).withRenderingMode(.alwaysTemplate)
    }
}

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    func imageWithColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
