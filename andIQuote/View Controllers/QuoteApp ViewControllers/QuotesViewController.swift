//
//  QuotesViewController.swift
//  andIQuote
//
//  Created by s on 3/6/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

extension QuotesViewController {
    enum Section {
        case main
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Quote>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Quote>
}

class QuotesViewController: UIViewController {
    var quoteController: QuoteController! = nil
    var collectioView: UICollectionView! = nil
    var dataSource: DataSource! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

        createCollectionView()

    }

    private func createLayout() -> UICollectionViewLayout {

        return UICollectionViewLayout()
    }


    func createCollectionView() {
        collectioView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectioView.translatesAutoresizingMaskIntoConstraints = false
        collectioView.register(QuoteCollectionViewCell.self, forCellWithReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier)

        view.addSubview(collectioView)

        NSLayoutConstraint.activate([
            collectioView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectioView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectioView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectioView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

    private func configureDataSource(items: [Quote]) {
        dataSource = DataSource(collectionView: collectioView, cellProvider: {
            collectioView, indexPath, quote -> UICollectionViewCell? in
            let cell = collectioView.dequeueReusableCell(withReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier, for: indexPath)

            return cell
        })


        var snapShot = SnapShot()

        snapShot.appendSections([.main])
        snapShot.appendItems(items)

        dataSource.apply(snapShot, animatingDifferences: false)
    }
}
