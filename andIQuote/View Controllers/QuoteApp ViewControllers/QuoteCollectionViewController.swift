//
//  QuoteViewController.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

typealias QuoteDataSource = UICollectionViewDiffableDataSource<QuoteCollectionViewController.Section, Quote>
typealias QuoteSourceSnapShot = NSDiffableDataSourceSnapshot<QuoteCollectionViewController.Section, Quote>

extension QuoteCollectionViewController {
    enum Section {
        case main
    }
}

class QuoteCollectionViewController: UICollectionViewController {
    var delegate: HomeControllerViewDelegate?
    var quoteController: QuoteController!
    var dataSource: QuoteDataSource!
    var shareButton: UIButton!
    var leftSwipeGestureRecognizer: UISwipeGestureRecognizer!
    var upSwipeGestureRecognizer: UISwipeGestureRecognizer!
    var downSwipeGestureRecognizer: UISwipeGestureRecognizer!
    var doubleTapSwipeGestureRecognizer: UITapGestureRecognizer!
    var reviewButton: UIButton!
    var likeButton: UIButton!
    
    var currentIndex = 0
    
    // MARK: lowerStackView
    var lowerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 32
        return stackView
    }()
    
    var slideMenuButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "", withConfiguration: UIImage().mainViewSymbolConfig())
        button.setImage(image, for: .normal)
        return button
    }()

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureDataSource()
        setupNavButtons()
        createSnapShot()
    }

    // MARK: configureDataSource
    private func configureDataSource() {
        dataSource = QuoteDataSource(collectionView: collectionView) {
            (collectionView, indexPath, quote) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier, for: indexPath) as! QuoteCollectionViewCell
            cell.quote = quote
            cell.setBackground(to: self.quoteController.background)
            return cell
        }
    }
    // MARK: createSnapShot
    private func createSnapShot() {
        quoteController.fetchQuotes { error in
            if let error = error {
                NSLog("\(error)")
            }
            var snapShot = QuoteSourceSnapShot()
            snapShot.appendSections([.main])
            snapShot.appendItems(self.quoteController.quotes)
            self.dataSource.apply(snapShot, animatingDifferences: false)
        }
    }
}
// MARK: SlideMenuEventsDelegate
extension QuoteCollectionViewController: SlideMenuEventsDelegate {
    func handleSlideMenuEvents(_ index: Int) {
        print(index)
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
        
        reviewButton = UIButton().sfImageButton(systemName: "text.bubble")
        reviewButton.addTarget(self, action: #selector(reviewButtonTapped), for: .touchUpInside)
        lowerStackView.addArrangedSubview(reviewButton)
        
        likeButton = UIButton().sfImageButton(systemName: "hand.thumbsup")
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        lowerStackView.addArrangedSubview(likeButton)
        collectionView.addSubview(lowerStackView)
        
        NSLayoutConstraint.activate([
            lowerStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            lowerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    // MARK: setupCollectionView
    private func setupCollectionView() {
        collectionView.isPagingEnabled = true
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleHeight]
        collectionView.setBackground(to: quoteController.background)
        collectionView.register(QuoteCollectionViewCell.self, forCellWithReuseIdentifier: QuoteCollectionViewCell.reuseIdentifier)
    }
    // MARK: setupSwipeGestureRecognizer
    private func setupSwipeGestureRecognizer() {
        leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeAction(_:)))
        leftSwipeGestureRecognizer.isEnabled = false
        leftSwipeGestureRecognizer.direction = .left
        collectionView.addGestureRecognizer(leftSwipeGestureRecognizer)
        
        upSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(shareButtonTapped))
        upSwipeGestureRecognizer.direction = .up
        collectionView.addGestureRecognizer(upSwipeGestureRecognizer)
        
        downSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(reviewButtonTapped))
        downSwipeGestureRecognizer.direction = .down
        collectionView.addGestureRecognizer(downSwipeGestureRecognizer)
        
        doubleTapSwipeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped(_:)))
        doubleTapSwipeGestureRecognizer.numberOfTapsRequired = 2
        collectionView.addGestureRecognizer(doubleTapSwipeGestureRecognizer)
    }
    // MARK: setupNavButtons
    private func setupNavButtons() {
        navigationController?.navigationBar.barTintColor = collectionView.backgroundColor
        navigationController?.navigationBar.barStyle = .default
        
        let menuImage = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(slideMenuButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        let shareImage = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    // MARK: handleSlideMenuToggle
    private func handleSlideMenuToggle() {
        delegate?.handleMenuToggle()
        collectionView.isScrollEnabled.toggle()
        leftSwipeGestureRecognizer.isEnabled.toggle()
        upSwipeGestureRecognizer.isEnabled.toggle()
        downSwipeGestureRecognizer.isEnabled.toggle()
        doubleTapSwipeGestureRecognizer.isEnabled.toggle()
    }
    // MARK: handleSwipeAction
    @objc private func handleSwipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .up {
            shareButtonTapped()
        }else if sender.direction == .down {
            reviewButtonTapped()
        }else {
            handleSlideMenuToggle()
        }
    }
    // MARK: slideMenuButtonTapped
    @objc func slideMenuButtonTapped() {
        guard !quoteController.quoteThemeIsActive else { return }
        impactGesture(style: .rigid)
        handleSlideMenuToggle()
    }
    // MARK: shareButtonTapped
    @objc func shareButtonTapped() {
        guard quoteController.quoteThemeIsActive != true else { return }
        impactGesture(style: .rigid)
        lowerStackView.isHidden = true
        let activityVC = UIActivityViewController(activityItems: [quoteController.attributedString, view.screenShot()], applicationActivities: [])
        present(activityVC, animated: true)
        lowerStackView.isHidden = false
    }
    // MARK: ReviewButtonTapped
    @objc func reviewButtonTapped() {
        impactGesture(style: .medium)
        let layout = UICollectionViewFlowLayout()
        let quoteReviewCollectionViewController = QuoteReviewCollectionViewController(collectionViewLayout: layout)
        quoteReviewCollectionViewController.quoteController = quoteController
        present(quoteReviewCollectionViewController, animated: true)
    }
    // MARK: likeButtonTapped
    @objc func likeButtonTapped(_ sender: UIButton) {
        print("like")
    }
    // MARK: Impact Gesture
    func impactGesture(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactFeedback = UIImpactFeedbackGenerator(style: style)
        impactFeedback.impactOccurred()
    }
}
