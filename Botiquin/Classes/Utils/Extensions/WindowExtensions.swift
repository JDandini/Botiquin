//
//  WindowExtensions.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import UIKit

extension UIApplication {
    class var currentWindow: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return nil }
        return delegate.window
    }
}
