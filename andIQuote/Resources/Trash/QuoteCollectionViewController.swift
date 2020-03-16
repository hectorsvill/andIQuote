//
//  QuoteViewController.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Firebase
import UIKit

typealias QuoteDataSource = UICollectionViewDiffableDataSource<QuoteCollectionViewController.Section, Quote>
typealias QuoteSourceSnapShot = NSDiffableDataSourceSnapshot<QuoteCollectionViewController.Section, Quote>

extension QuoteCollectionViewController {
    enum Section {
        case main
    }
}

final class QuoteCollectionViewController: UICollectionViewController {
    var activityIndicator = UIActivityIndicatorView()
    var userNotificationCenter: UNUserNotificationCenter!
    var delegate: HomeControllerViewDelegate?
    var quoteController: QuoteController!
    var dataSource: QuoteDataSource!
    var shareButton: UIButton!
    var leftSwipeGestureRecognizer: UISwipeGestureRecognizer!
    var rightSwipeGestureRecognizer: UISwipeGestureRecognizer!
    var upSwipeGestureRecognizer: UISwipeGestureRecognizer!
    var downSwipeGestureRecognizer: UISwipeGestureRecognizer!
    var doubleTapSwipeGestureRecognizer: UITapGestureRecognizer!
    var reviewButton: UIButton!
    var likeButton: UIButton!
    var themeButton: UIButton!
    // MARK: lowerStackView
    var lowerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 32
        return stackView
    }()
    // MARK: trademarkLabel
    let trademarkLabel: UILabel = {
        let textview = UILabel()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.textAlignment = .justified
        textview.textColor = .label
        textview.isHidden = true
        return textview
    }()
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = quoteController.trademarkAttributedString.string
        setupSwipeGestureRecognizer()
        setupViews()
        setupCollectionView()
        setupNavButtons()
        loadLastIndex()
        createActivityIndicator()
    }

    // MARK: setupViews
    private func setupViews() {
        trademarkLabel.attributedText = quoteController.trademarkAttributedString

        themeButton = UIButton().sfImageButton(systemName: "paintbrush")
        themeButton.addTarget(self, action: #selector(themeButtonTapped), for: .touchUpInside)
        lowerStackView.addArrangedSubview(themeButton)

        reviewButton = UIButton().sfImageButton(systemName: "bell")
        reviewButton.addTarget(self, action: #selector(reminderButtonTapped), for: .touchUpInside)
        lowerStackView.addArrangedSubview(reviewButton)

//        likeButton = UIButton().sfImageButton(systemName: "hand.thumbsup")
//        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
//        lowerStackView.addArrangedSubview(likeButton)


        collectionView.addSubview(lowerStackView)
        collectionView.addSubview(trademarkLabel)
        NSLayoutConstraint.activate([
            lowerStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            lowerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            trademarkLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            trademarkLabel.bottomAnchor.constraint(equalTo: lowerStackView.topAnchor),
        ])
    }
    // MARK: setupNavButtons
    private func setupNavButtons() {
        navigationController?.navigationBar.barTintColor = collectionView.backgroundColor
        navigationController?.navigationBar.barStyle = .default
//
//        let menuImage = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage().mainViewSymbolConfig())
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(slideMenuButtonTapped))
//        navigationItem.leftBarButtonItem?.tintColor = .label

        let shareImage = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
}
// MARK: UICollectionViewDelegateFlowLayout
extension QuoteCollectionViewController: UICollectionViewDelegateFlowLayout {
    // MARK: scrollViewWillEndDragging
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentIndex = Int(targetContentOffset.pointee.x / view.frame.width)
        quoteController.setQuoteIndex(currentIndex)
    }

    // MARK: minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension QuoteCollectionViewController {
    // MARK: loadLastIndex
    private func loadLastIndex() {
        DispatchQueue.main.async {
            let item = self.quoteController._quoteIndex
            let index = IndexPath(item: item, section: 0)
            self.collectionView.scrollToItem(at: index, at: .left, animated: false)
        }
    }
    // MARK: createActivityIndicator
    private func createActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    // MARK: setupCollectionView
    private func setupCollectionView() {
        collectionView.isPagingEnabled = true
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleHeight]
        collectionView.setBackground(to: quoteController.background)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.register(QuoteCollectionViewCell.self, forCellWithReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier)
        configureDataSource()
        createSnapShot()
    }
    // MARK: configureDataSource
    private func configureDataSource() {
        dataSource = QuoteDataSource(collectionView: collectionView) {
            (collectionView, indexPath, quote) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier, for: indexPath) as! QuoteCollectionViewCell
            cell.quote = quote
            cell.quoteController = self.quoteController
            cell.backgroundColor = .clear
            return cell
        }
    }
    // MARK: createSnapShot
    private func createSnapShot() {
        quoteController.fetchQuotes { quotes, error in
            if let error = error {
                NSLog("\(error)")
            }
            DispatchQueue.main.async {
                guard let quotes = quotes else { return }
                print("createSnapShot: \(quotes.count)")
                var snapShot = QuoteSourceSnapShot()
                snapShot.appendSections([.main])
                snapShot.appendItems(quotes)
                self.dataSource.apply(snapShot, animatingDifferences: true)
                self.activityIndicator.stopAnimating()
            }
        }
    }

//    // MARK: handleSlideMenuToggle
    func handleSlideMenuToggle() {
        delegate?.handleMenuToggle(index: 0)
        collectionView.isScrollEnabled.toggle()
        leftSwipeGestureRecognizer.isEnabled.toggle()
        upSwipeGestureRecognizer.isEnabled.toggle()
        downSwipeGestureRecognizer.isEnabled.toggle()
//        doubleTapSwipeGestureRecognizer.isEnabled.toggle()
    }
    // MARK: slideMenuButtonTapped
    @objc func slideMenuButtonTapped() {
        guard !quoteController.quoteThemeIsActive else { return }
        impactGesture(style: .rigid)
        handleSlideMenuToggle()
    }
    // MARK: themebutton tapped
    @objc func themeButtonTapped(_ sender: UIButton) {
        impactGesture(style: .medium)
        quoteController.quoteThemeIsActive.toggle()
        let themeViewController = ThemeViewController()
        themeViewController.quoteController = quoteController
        themeViewController.delegate = self
        present(themeViewController, animated: true)

    }
    // MARK: shareButtonTapped
    @objc func shareButtonTapped() {
        guard quoteController.quoteThemeIsActive != true else { return }
        impactGesture(style: .rigid)
        lowerStackView.isHidden.toggle()
        trademarkLabel.isHidden.toggle()
        let activityVC = UIActivityViewController(activityItems: [quoteController.attributedString, view.screenShot()], applicationActivities: [])
        present(activityVC, animated: true)
        lowerStackView.isHidden.toggle()
        trademarkLabel.isHidden.toggle()
    }
    // MARK: reminderButtonTapped
    @objc func reminderButtonTapped() {
        guard quoteController.quoteThemeIsActive != true else { return }
        impactGesture(style: .medium)
        let dailyReminderVC = DailyReminderViewController()
        dailyReminderVC.userNotificationCenter = userNotificationCenter
        dailyReminderVC.quoteController = quoteController
        dailyReminderVC.view.setBackground(to: quoteController.background)
        present(dailyReminderVC, animated: true)
        
    }
//    // MARK: likeButtonTapped
    @objc func likeButtonTapped(_ sender: UIButton) {
        print("like")
    }

    // MARK: Impact Gesture
    func impactGesture(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactFeedback = UIImpactFeedbackGenerator(style: style)
        impactFeedback.impactOccurred()
    }
}
extension QuoteCollectionViewController: ThemeViewControllerDelegate {
    func makeBackgroundChange(_ selectedItem: Int) {
        quoteController.setBackgroundIndex(selectedItem)
        collectionView.setBackground(to: quoteController.backgrounds[selectedItem])
        collectionView.reloadData()
        navigationController?.navigationBar.barTintColor = collectionView.backgroundColor
    }
}

// MARK: UNUserNotificationCenterDelegate
extension QuoteCollectionViewController: UNUserNotificationCenterDelegate {
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
            userNotificationCenter.add(request) { error in
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
