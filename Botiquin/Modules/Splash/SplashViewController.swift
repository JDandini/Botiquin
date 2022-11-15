//
//  SplashViewController.swift
//  Botiquin
//
//  Created by Javier Castañeda on 06/11/22.
//

import UIKit
import Combine

final class SplashViewController: UIViewController {

    struct Metrics {
        static let offset: CGFloat = 20
        static let footerHeight: CGFloat = 60
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "emotions")
        return imageView
    }()

    private let footerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mainGreen
        return view
    }()
    var viewModel: SplashViewModel =  SplashViewModel()
    var publishers: Set<AnyCancellable> = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel
            .imagePubliser
            .sink { [weak self] _ in
                self?.navigateToLogin()
            } receiveValue: {[weak self] image in
                self?.imageView.image = image
            }
            .store(in: &publishers)
        viewModel.start()
    }

    private func setupUI() {

        view.addSubview(imageView)
        view.addSubview(footerView)

        view.addConstraints([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.offset),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Metrics.offset),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.offset),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.offset),

            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: Metrics.footerHeight)
        ])
    }

    private func navigateToLogin() {
        guard let loginViewController = LoginBuilder.buildModule() else { return }
        let window = UIApplication.currentWindow
        window?.rootViewController = loginViewController
    }
}
