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
    var themeButton: UIButton!
    var ReviewButton: UIButton!
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

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureDataSource()
        setupNavButtons()
        createSnapShot()
        
        collectionView.isPagingEnabled = true
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleHeight]
        
    }

    // MARK: configureDataSource
    private func configureDataSource() {
        dataSource = QuoteDataSource(collectionView: collectionView) {
            (collectionView, indexPath, quote) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuoteCell.reuseIdentifier, for: indexPath) as! QuoteCell
            cell.quote = quote
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

// MARK: UICollectionViewDelegateFlowLayout
extension QuoteCollectionViewController: UICollectionViewDelegateFlowLayout {
    // MARK: collectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    // MARK: scrollViewWillEndDragging
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        currentIndex = Int(targetContentOffset.pointee.x / view.frame.width)
        print(currentIndex)
    }
    
    // MARK: minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension QuoteCollectionViewController {
    // MARK: setupNavButtons
    private func setupNavButtons() {
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        navigationController?.navigationBar.barStyle = .default
        
        let menuImage = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        let shareImage = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    // MARK: setupViews
    private func setupViews() {
        collectionView.setBackground(to: quoteController.background)
        collectionView.register(QuoteCell.self, forCellWithReuseIdentifier: QuoteCell.reuseIdentifier)
        themeButton = UIButton().sfImageButton(systemName: "paintbrush")
        themeButton.addTarget(self, action: #selector(themeButtonTapped), for: .touchUpInside)
        lowerStackView.addArrangedSubview(themeButton)

        ReviewButton = UIButton().sfImageButton(systemName: "text.bubble")
        ReviewButton.addTarget(self, action: #selector(ReviewButtonTapped), for: .touchUpInside)
        lowerStackView.addArrangedSubview(ReviewButton)

        likeButton = UIButton().sfImageButton(systemName: "hand.thumbsup")
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        lowerStackView.addArrangedSubview(likeButton)

        collectionView.addSubview(lowerStackView)

        NSLayoutConstraint.activate([
           lowerStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
           lowerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    
    // MARK: menuButtonTapped
    @objc func menuButtonTapped() {
        guard !quoteController.quoteThemeIsActive else { return }
        impactGesture(style: .rigid)
        delegate?.handleMenuToggle()
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
    
    // MARK: themeButtonTapped
    @objc func themeButtonTapped() {
        impactGesture(style: .medium)
        quoteController.quoteThemeIsActive.toggle()
        let buttonImageName = quoteController.quoteThemeIsActive ? "paintbrush.fill" : "paintbrush"
        let configuration = UIImage().mainViewSymbolConfig()
        let image = UIImage(systemName: buttonImageName, withConfiguration: configuration)
        themeButton.setImage(image, for: .normal)
        quoteController.saveBackgroundIndex()
    }
    
    // MARK: ReviewButtonTapped
    @objc func ReviewButtonTapped() {
        impactGesture(style: .medium)
        let layout = UICollectionViewFlowLayout()
        let quoteReviewCollectionViewController = QuoteReviewCollectionViewController(collectionViewLayout: layout)
        quoteReviewCollectionViewController.quoteController = quoteController
        present(quoteReviewCollectionViewController, animated: true)
    }
    
    // MARK: likeButtonTapped
    @objc func likeButtonTapped() {
        guard !quoteController.quoteThemeIsActive else { return }
        impactGesture(style: .medium)
        
        let quoteID = quoteController.quote.id
        var buttonImageName =  "hand.thumbsup"
        guard var user = quoteController.quoteUser else { return }
        
        if user.favorites.contains(quoteID!) {
            if let index = user.favorites.firstIndex(of: quoteID!) {
                user.favorites.remove(at: index)
            }
        } else {
            user.favorites.append(quoteID!)
            buttonImageName =  "hand.thumbsup.fill"
        }
        
        let configuration = UIImage().mainViewSymbolConfig()
        let image = UIImage(systemName: buttonImageName, withConfiguration: configuration)
        likeButton.setImage(image, for: .normal)
        
        quoteController.likeButtonpressed()
    }
    
    // MARK: Impact Gesture
    func impactGesture(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactFeedback = UIImpactFeedbackGenerator(style: style)
        impactFeedback.impactOccurred()
    }
}
