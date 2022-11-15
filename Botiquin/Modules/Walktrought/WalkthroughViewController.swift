//
//  WalktroughtViewController.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import UIKit

final class WalkthroughViewController: UIViewController {
    struct Metrics {
        static let offset: CGFloat = 40
        static let footerHeight: CGFloat = 60
        static let pageIndicatorHeight: CGFloat = 20
        static let minimumOffset: CGFloat = 10
    }
    private let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sit amet lectus sit amet odio sodales posuere tristique auctor nisi. Donec felis lectus, imperdiet vel augue vitae, maximus elementum urna. Etiam euismod nulla vitae lacus porttitor pulvinar."

    private let footerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mainGreen
        return view
    }()

    private let pageControl: FlexiblePageControl = {
        let pageControl = FlexiblePageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = 3
        return pageControl
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(footerView)
        view.addSubview(pageControl)
        view.addSubview(collectionView)
        collectionView.register(WalkthroughCell.self, forCellWithReuseIdentifier: WalkthroughCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func setupConstraints() {
        view.addConstraints([
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: Metrics.footerHeight),

            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -Metrics.minimumOffset),
            pageControl.heightAnchor.constraint(equalToConstant: Metrics.pageIndicatorHeight),

            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.offset),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -Metrics.minimumOffset)
        ])
    }
}

extension WalkthroughViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: WalkthroughCell.identifier, for: indexPath)
        guard let cell = dequeuedCell as? WalkthroughCell else {
            return dequeuedCell
        }
        cell.configure(with: loremIpsum)
        return cell
    }
}

extension WalkthroughViewController: UICollectionViewDelegate {}

extension WalkthroughViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

extension WalkthroughViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.setProgress(contentOffsetX: scrollView.contentOffset.x,
                                pageWidth: scrollView.bounds.width)
    }
}
