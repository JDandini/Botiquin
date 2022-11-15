//
//  LoginPresenter.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import Foundation

final class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol?

    func didPressLoginButton() {
        router?.navigateToWalktrought(from: view)
    }
}
