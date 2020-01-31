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

class QuoteCollectionViewController: UICollectionViewController {
    var activityIndicator = UIActivityIndicatorView()
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
        setupViews()
        configureDataSource()
        setupNavButtons()
        createSnapShot()
        loadLastIndex()


        title = quoteController.trademarkAttributedString.string
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    // MARK: loadLastIndex
    private func loadLastIndex() {
        let index = IndexPath(item: quoteController._quoteIndex, section: 0)
        collectionView.scrollToItem(at: index, at: .left, animated: false)
    }
    // MARK: setupCollectionView
    private func setupCollectionView() {
        collectionView.isPagingEnabled = true
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleHeight]
        collectionView.setBackground(to: quoteController.background)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(QuoteCollectionViewCell.self, forCellWithReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier)
    }
    // MARK: configureDataSource
    private func configureDataSource() {
        dataSource = QuoteDataSource(collectionView: collectionView) {
            (collectionView, indexPath, quote) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier, for: indexPath) as! QuoteCollectionViewCell
            cell.quote = quote
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
            var snapShot = QuoteSourceSnapShot()
            DispatchQueue.main.async {
                snapShot.appendSections([.main])
                snapShot.appendItems(quotes ?? [])
                self.dataSource.apply(snapShot, animatingDifferences: false)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
// MARK: UICollectionViewDelegateFlowLayout
extension QuoteCollectionViewController: UICollectionViewDelegateFlowLayout {
    // MARK: collectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    // MARK: scrollViewWillEndDragging
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentIndex = Int(targetContentOffset.pointee.x / view.frame.width)
        quoteController.setIndex(currentIndex)
        
        let numberOfItems = dataSource.snapshot().numberOfItems

        if currentIndex == numberOfItems - 1 {
            quoteController.getNextQuote { _ , error in
                if let error = error {
                    NSLog("\(error)")
                }
                
                self.createSnapShot()
            }
        }
    }
    // MARK: minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension QuoteCollectionViewController {
    // MARK: setupViews
    private func setupViews() {
        setupCollectionView()
        setupSwipeGestureRecognizer()

        trademarkLabel.attributedText = quoteController.trademarkAttributedString
        
        reviewButton = UIButton().sfImageButton(systemName: "bell")
        reviewButton.addTarget(self, action: #selector(reminderButtonTapped), for: .touchUpInside)
        lowerStackView.addArrangedSubview(reviewButton)
        
//        likeButton = UIButton().sfImageButton(systemName: "hand.thumbsup")
//        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
//        lowerStackView.addArrangedSubview(likeButton)
//        collectionView.addSubview(lowerStackView)

        themeButton = UIButton().sfImageButton(systemName: "paintbrush")
        themeButton.addTarget(self, action: #selector(themeButtonTapped), for: .touchUpInside)
        lowerStackView.addArrangedSubview(themeButton)
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
        
//        let menuImage = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage().mainViewSymbolConfig())
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(slideMenuButtonTapped))
//        navigationItem.leftBarButtonItem?.tintColor = .label
        
        let shareImage = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
//    // MARK: handleSlideMenuToggle
//    func handleSlideMenuToggle() {
//        delegate?.handleMenuToggle()
//        collectionView.isScrollEnabled.toggle()
//        leftSwipeGestureRecognizer.isEnabled.toggle()
//        upSwipeGestureRecognizer.isEnabled.toggle()
//        downSwipeGestureRecognizer.isEnabled.toggle()
//        doubleTapSwipeGestureRecognizer.isEnabled.toggle()
//    }
    // MARK: slideMenuButtonTapped
//    @objc func slideMenuButtonTapped() {
//        guard !quoteController.quoteThemeIsActive else { return }
//        impactGesture(style: .rigid)
//        handleSlideMenuToggle()
//    }
    // MARK: themebutton tapped
    @objc func themeButtonTapped(_ sender: UIButton) {
        impactGesture(style: .medium)
        quoteController.quoteThemeIsActive.toggle()
        collectionView.isScrollEnabled.toggle()
        leftSwipeGestureRecognizer.isEnabled.toggle()
        rightSwipeGestureRecognizer.isEnabled.toggle()
        let brush = quoteController.quoteThemeIsActive ? "paintbrush.fill" : "paintbrush"
        let image = UIImage(systemName: brush, withConfiguration: UIImage().mainViewSymbolConfig())
        themeButton.setImage(image, for: .normal)
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
        dailyReminderVC.quoteController = quoteController
        present(dailyReminderVC, animated: true)
        
    }
//    // MARK: likeButtonTapped
//    @objc func likeButtonTapped(_ sender: UIButton) {
//        print("like")
//    }

    // MARK: Impact Gesture
    func impactGesture(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactFeedback = UIImpactFeedbackGenerator(style: style)
        impactFeedback.impactOccurred()
    }
}

