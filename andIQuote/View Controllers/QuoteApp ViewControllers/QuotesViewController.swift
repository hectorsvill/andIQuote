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
    enum Section { case main }
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Quote>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Quote>
}

final class QuotesViewController: UIViewController {
    var userNotificationCenter: UNUserNotificationCenter?
    let defaults = UserDefaults.standard
    var quoteController: QuoteController! = nil
    var activityIndicator: UIActivityIndicatorView! = nil
    var collectionView: UICollectionView! = nil
    var dataSource: DataSource! = nil
    var delegate: HomeControllerViewDelegate? = nil
}

extension QuotesViewController {
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        userNotificationCenter?.delegate = self
        fetchQotes()
        createCollectionView()
        configureDataSource()
        configureNavigationButton()
        createActivityIndicator()
        loadLastIndex()
    }

    func loadLastIndex() {
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: IndexPath(item: self.quoteController._quoteIndex, section: 0), at: .left, animated: false)
        }
    }

    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.tintColor = .label
        collectionView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = collectionView.center
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

        DispatchQueue.main.async {
            self.quoteController.setQuoteIndex(indexPath.item)
        }
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

    // MARK: - PERESNTVIEWS

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
        vc.searchData = quoteController.authors
        vc.searchData.sort()
        vc.delegate = self
        present(UINavigationController(rootViewController: vc), animated: true)
    }

    func presentSubmitView() {
        let vc = SubmitViewController()
        vc.authors = quoteController.authors
        
        present(UINavigationController(rootViewController: vc), animated: true)

    }
}
// MARK: - UNUserNotificationCenterDelegate
extension QuotesViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let notification = response.notification
        let id = notification.request.identifier
        let index = fetchQuoteIndex(id)

        DispatchQueue.main.async {
            let index = IndexPath(item: index, section: 0)
            self.collectionView.scrollToItem(at: index, at: .left, animated: false)
            self.collectionView.reloadData()
//            self.shareButtonTapped()
            self.addNextNotification(with: notification.request.content)
        }

        completionHandler()
    }
    // MARK: addNextNotification
    private func addNextNotification(with content: UNNotificationContent) {
        let badge = content.badge as! Int

        if badge <= quoteController.remindersCount {
            let quote = dataSource.snapshot().itemIdentifiers.randomElement()!
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = quote.author!
            notificationContent.body = quote.body!
            notificationContent.badge = NSNumber(integerLiteral: badge + 1)
            notificationContent.sound = content.sound
            let timeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: quoteController.reminderTimeIntervalSeconds, repeats: false)
            let request = UNNotificationRequest(identifier: quote.id!, content: notificationContent, trigger: timeIntervalTrigger)
            userNotificationCenter?.add(request) { error in
                if let error = error {
                    // TODO: create uialert with error
                    NSLog("Error: \(error)")
                }
            }
        }
    }
    // MARK: fetchQuoteIndex
    private func fetchQuoteIndex(_ id: String) -> Int {
        let items = dataSource.snapshot().itemIdentifiers

        for (i, item) in items.enumerated() {
            if item.id == id { return i }
        }

        return 0
    }
}
