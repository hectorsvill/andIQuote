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
    let activityIndicator = UIActivityIndicatorView(style: .large)

    var collectioView: UICollectionView! = nil
    var dataSource: DataSource! = nil

    var quotes: [Quote] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionView()

        activityIndicator.color = .black
        activityIndicator.center = collectioView.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        fetchQotes()
    }

    private func fetchQotes() {
        quoteController.fetchQuotes { quotes, error in
            if let error = error {
                NSLog("Error: \(error)")
            }

            guard let quotes = quotes else { return }
            DispatchQueue.main.async {
                self.quotes = quotes
                self.collectioView.reloadData()
                self.activityIndicator.stopAnimating()
                self.configureDataSource(items: quotes)
            }

        }


    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)//UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.6))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)


        return UICollectionViewCompositionalLayout(section: section)
    }

    func createCollectionView() {
        collectioView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectioView.translatesAutoresizingMaskIntoConstraints = false
        collectioView.setBackground(to: quoteController.background)
        collectioView.register(QuoteCollectionViewCell.self, forCellWithReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier)
//        collectioView.dataSource = self
        view.addSubview(collectioView)

        NSLayoutConstraint.activate([
            collectioView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectioView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectioView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectioView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

    private func configureDataSource(items: [Quote]) {

        dataSource = DataSource(collectionView: collectioView) {
            collectioView, indexPath, quote -> UICollectionViewCell? in
            guard let cell = collectioView.dequeueReusableCell(withReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier, for: indexPath) as? QuoteCollectionViewCell else { return UICollectionViewCell() }
            cell.quote = quote
            cell.quoteController = self.quoteController

            cell.layer.borderWidth = 3
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.cornerRadius = 12
            return cell
        }

        var snapShot = SnapShot()
        snapShot.appendSections([.main])
        snapShot.appendItems(items)

        dataSource.apply(snapShot, animatingDifferences: true)
        activityIndicator.stopAnimating()
    }
}

//extension QuotesViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return quotes.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier, for: indexPath) as? QuoteCollectionViewCell else { return UICollectionViewCell() }
//        cell.quote = quotes[indexPath.item]
//        cell.quoteController = quoteController
//        return cell
//    }
//
//
//}
