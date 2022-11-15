//
//  LoginBuilder.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import UIKit

struct LoginBuilder: LoginBuilderProtocol {
    static func buildModule() -> UIViewController? {
        let view = LoginViewController()
        let presenter = LoginPresenter()
        let router = LoginRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router

        return view
    }
}
