//
//  SplashViewModel.swift
//  Botiquin
//
//  Created by Javier Castañeda on 08/11/22.
//

import UIKit
import Combine

final class SplashViewModel {
    private let delayInSeconds: TimeInterval = 1.5
    private var index: Int = 0
    private var images: [UIImage] = []
    let imagePubliser: PassthroughSubject<UIImage, Never> = PassthroughSubject<UIImage, Never>()

    func start() {
        let imageNames = ["emotions",
                          "first-aid-kit",
                          "cim",
                          "education-services"]
        images = imageNames.compactMap { UIImage(named: $0) }
        startImagePublisher()
    }

    private func startImagePublisher() {
        Timer.scheduledTimer(withTimeInterval: delayInSeconds, repeats: true) { [weak self] timer in
            guard let self = self,
                  let image = self.images.get(self.index) else {
                timer.invalidate()
                self?.imagePubliser.send(completion: .finished)
                return
            }
            self.imagePubliser.send(image)
            self.index += 1
        }
    }
}
