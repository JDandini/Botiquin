//
//  LoginProtocols.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
}

protocol LoginPresenterProtocol: AnyObject {
    var view: LoginViewProtocol? { get set }
    var router: LoginRouterProtocol? { get set }

    func didPressLoginButton()
}

protocol LoginRouterProtocol: AnyObject {
    func navigateToWalktrought(from view: LoginViewProtocol?)
}

protocol LoginBuilderProtocol {
    static func buildModule() -> UIViewController?
}
