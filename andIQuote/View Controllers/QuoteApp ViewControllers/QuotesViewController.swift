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
    let defaults = UserDefaults.standard
    var quoteController: QuoteController! = nil
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var collectionView: UICollectionView! = nil
    var dataSource: DataSource! = nil
    var delegate: HomeControllerViewDelegate? = nil
    var lastIndex = UserDefaults().integer(forKey: "QuotesViewController.lastIndex")
}

extension QuotesViewController {
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchQotes()
        createCollectionView()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tintColor = .red
        activityIndicator.center = collectionView.center
        activityIndicator.startAnimating()
        collectionView.addSubview(activityIndicator)

        configureDataSource()
        configureNavigationButton()

        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(item: self.lastIndex, section: 0), at: .right, animated: true)
        }
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
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

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
}

// MARK: UICollectionViewDelegate
extension QuotesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if quoteController.menuNavigationIsExpanded {
            delegate?.handleMenuToggle(index: 0)
        }

        lastIndex = indexPath.item
        UserDefaults.standard.set(self.lastIndex, forKey: "QuotesViewController.lastIndex")
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

extension QuotesViewController: SearchViewControllerDelegate {
    func loadSearchData(_ author: String) {
        let author_quotes = quoteController.quotesDict[author]!
        loadData(items: author_quotes)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        }
    }
}

extension QuotesViewController {
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

        if bookmarkedQuotes.count == 0 {
            let alertController = UIAlertController(title: "andIQuote", message: "Bookmarks are empty!", preferredStyle: .actionSheet)

            alertController.addAction(UIAlertAction(title: "OK", style: .default){ _ in
                self.quoteController.bookmarkViewIsActive = false
                self.loadData(items: self.quoteController.quotes)
            })

            present(alertController, animated:  true)
        }
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

    func presentCreateQuoteView() {
        let vc = CreateQuoteViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

    func presentSearchView() {
        let vc = SearchViewController()
        vc.data = quoteController.quotesDict.keys.map { return String($0) }
        vc.data.sort()
//        vc.searchData.removeFirst()
        vc.delegate = self
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}
