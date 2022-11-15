//
//  WalktroughtCell.swift
//  Botiquin
//
//  Created by Javier Castañeda on 15/11/22.
//

import UIKit

final class WalktroughtCell: UICollectionViewCell {
    static let identifier: String = "WalktroughtCell"
    struct Metrics {
        static let marginOffset: CGFloat = 100
        static let offset: CGFloat = 20
    }

    private let cardView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0.5, height: 0.9)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()

    private let firstAidKitOutline: UIImageView = {
        let image = UIImage(named: "first-aid-outline")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let firstAidKit: UIImageView = {
        let image = UIImage(named: "first-aid-kit")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let indicationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .h2
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        contentView.addSubview(cardView)
        cardView.addSubview(firstAidKitOutline)
        cardView.addSubview(firstAidKit)
        cardView.addSubview(indicationLabel)
    }

    private func setupConstraints() {
        contentView.addConstraints([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.marginOffset),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.offset),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.offset),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.offset),

            firstAidKit.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Metrics.offset),
            firstAidKit.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Metrics.offset),
            firstAidKit.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.5),
            firstAidKit.heightAnchor.constraint(equalTo: firstAidKit.widthAnchor, multiplier: 1),

            firstAidKitOutline.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Metrics.offset / 4),
            firstAidKitOutline.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            firstAidKitOutline.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 1 / 8),
            firstAidKitOutline.widthAnchor.constraint(equalTo: firstAidKitOutline.heightAnchor, multiplier: 4 / 3),

            indicationLabel.topAnchor.constraint(equalTo: firstAidKit.bottomAnchor, constant: Metrics.offset),
            indicationLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Metrics.offset),
            indicationLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Metrics.offset),
            indicationLabel.bottomAnchor.constraint(equalTo: firstAidKitOutline.topAnchor, constant: -Metrics.offset)
        ])
    }

    func configure(with text: String) {
        indicationLabel.text = text
    }
}
