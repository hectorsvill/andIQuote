//
//  QuotesViewController.swift
//  andIQuote
//
//  Created by s on 3/6/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import CoreData
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
    var collectionView: UICollectionView! = nil
    var dataSource: DataSource! = nil
    var delegate: HomeControllerViewDelegate? = nil
}

extension QuotesViewController {

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.color = .black
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        fetchQotes()
        createCollectionView()
        configureDataSource()
        configureNavigationButton()
    }


    private func configureNavigationButton() {
        navigationController?.navigationBar.barTintColor = collectionView.backgroundColor
        navigationController?.navigationBar.barStyle = .default
        let menuImage = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(slideMenuButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .label
    }

    @objc func slideMenuButtonTapped() {
        delegate?.handleMenuToggle(index: 0)
        collectionView.isScrollEnabled.toggle()
    }


    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.6))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }

    func createCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        collectionView.delegate = self
        collectionView.setBackground(to: quoteController.background)
        collectionView.register(QuoteCollectionViewCell.self, forCellWithReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) {
            collectioView, indexPath, quote -> UICollectionViewCell? in
            guard let cell = collectioView.dequeueReusableCell(withReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier, for: indexPath) as? QuoteCollectionViewCell else { return UICollectionViewCell() }

            cell.quoteController = self.quoteController
            cell.quote = quote

            cell.layer.borderWidth = 0.25
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.cornerRadius = 12
            cell.backgroundColor = .clear
            return cell
        }
    }

    private func fetchQotes() {
        quoteController.fetchQuotes { quotes, error in
            if let error = error {
                NSLog("Error: \(error)")
            }

            guard let quotes = quotes else { return }
            DispatchQueue.main.async {
                self.loadData(items: quotes)
                self.activityIndicator.stopAnimating()
            }

        }
    }

    func loadData(items: [Quote]) {
        var snapShot = SnapShot()
        snapShot.appendSections([.main])
        snapShot.appendItems(items)

        self.dataSource.apply(snapShot, animatingDifferences: true)
    }
}
// MARK: UICollectionViewDelegate
extension QuotesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
