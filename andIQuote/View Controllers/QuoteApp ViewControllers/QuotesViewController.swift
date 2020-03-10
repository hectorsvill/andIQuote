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

final class QuotesViewController: UIViewController {
    var userNotificationCenter: UNUserNotificationCenter?
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

        fetchQotes()
        createCollectionView()

        collectionView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tintColor = .red
        activityIndicator.center = collectionView.center
        activityIndicator.startAnimating()

        configureDataSource()
        configureNavigationButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.isScrollEnabled = true
    }

    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
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
        dataSource = DataSource(collectionView: collectionView) { collectioView, indexPath, quote -> UICollectionViewCell? in
            guard let cell = collectioView.dequeueReusableCell(withReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier, for: indexPath) as? QuoteCollectionViewCell else { return UICollectionViewCell() }
            cell.backgroundColor = .systemBlue
            cell.quoteController = self.quoteController
            cell.quote = quote
            cell.delegate = self
            cell.isBookmark = quote.like
            let image = UIImage(systemName: cell.isBookmark ? "bookmark.fill" : "bookmark", withConfiguration: UIImage().mainViewSymbolConfig())!
            cell.bookmarkButton.setImage(image, for: .normal)
            return cell
        }
    }
}

extension QuotesViewController {
    private func configureNavigationButton() {
        navigationController?.navigationBar.barTintColor = collectionView.backgroundColor
        navigationController?.navigationBar.barStyle = .default
        let menuImage = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(slideMenuButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .label
    }

    @objc func slideMenuButtonTapped() {
        delegate?.handleMenuToggle(index: 0)
//        collectionView.isScrollEnabled.toggle()
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.8))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
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

    func fetchAllQuotes() {
        loadData(items: quoteController.quotes)
        collectionView.reloadData()
    }

    func fetchBookmarked() {
        let bookmarkedQuotes = quoteController.quotes.filter { $0.like == true && quoteController.bookmarked.contains($0.id!) }

        loadData(items: bookmarkedQuotes)
        collectionView.reloadData()
    }

    func presentThemeView() {
        let vc = ThemeViewController()
        vc.delegate = self
        vc.quoteController = quoteController
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true)
    }

    func pressentReminderView() {
        let vc = DailyReminderViewController()
        vc.quoteController = quoteController
        vc.userNotificationCenter = userNotificationCenter

        present(vc, animated: true)

    }
}

//extension QuotesViewController: Dail

// MARK: UICollectionViewDelegate
extension QuotesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: QuoteCollectionViewCellDelegate
extension QuotesViewController: QuoteCollectionViewCellDelegate {
    func bookmarkButtonPressed(_ id: String) {
        view.impactGesture(style: .rigid)

        if quoteController.bookmarked.contains(id) {
            if let index = quoteController.bookmarked.firstIndex(of: id) {
                quoteController.bookmarked.remove(at: index)

                if self.quoteController.bookmarkViewIsActive == true {

                    self.fetchBookmarked()
                }
            }
        } else {
            quoteController.bookmarked.append(id)
        }
    }

    func shareButtonPressed(_ view: UIView) {
        guard quoteController.quoteThemeIsActive != true else { return }
        view.impactGesture(style: .rigid)
        let activityVC = UIActivityViewController(activityItems: [quoteController.attributedString, view.screenShot()], applicationActivities: [])
        present(activityVC, animated: true)
    }
}

extension QuotesViewController: ThemeViewControllerDelegate {
    func makeBackgroundChange(_ selectedItem: Int) {
        quoteController.setBackgroundIndex(selectedItem)
        collectionView.reloadData()
    }
}
