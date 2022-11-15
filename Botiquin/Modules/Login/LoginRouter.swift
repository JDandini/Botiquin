//
//  LoginRouter.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import UIKit

final class LoginRouter: LoginRouterProtocol {
    func navigateToWalktrought(from view: LoginViewProtocol?) {
        let walktroughtView = WalkthroughViewController()
        UIApplication.currentWindow?.rootViewController = walktroughtView
        UIApplication.currentWindow?.makeKeyAndVisible()
    }
}
