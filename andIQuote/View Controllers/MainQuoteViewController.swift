//
//  MainQuoteViewController.swift
//  andIQuote
//
//  Created by Hector on 12/31/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

class MainQuoteViewController: UIViewController {
    let quoteController = QuoteController()
    var menuButton: UIButton!
    var shareButton: UIButton!
    var themeButton: UIButton!
    var ReviewButton: UIButton!
    var likeButton: UIButton!
    var quoteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavButtons()
        setupLayouts()
        setupQuoteText()
        setupGestureRecogniser()
        
    }
    
    
    private func setupQuoteText() {
        quoteTextView = UITextView()
        quoteTextView.translatesAutoresizingMaskIntoConstraints = false
        quoteTextView.backgroundColor = .clear
        quoteTextView.textAlignment = .justified
        quoteTextView.isEditable = false
        quoteTextView.isSelectable = false
        quoteTextView.isScrollEnabled = false
        
        quoteTextView.attributedText = quoteController.attributedString
        
        view.addSubview(quoteTextView)
        
        NSLayoutConstraint.activate([
            quoteTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quoteTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quoteTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            quoteTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupNavButtons() {
        let menuImage = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        let shareImage = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .label
        
    }
    
    private func setupLayouts() {
        themeButton = UIButton().sfImageButton(systemName: "paintbrush")
        themeButton.addTarget(self, action: #selector(themeButtonTapped), for: .touchUpInside)
        ReviewButton = UIButton().sfImageButton(systemName: "text.bubble")
        ReviewButton.addTarget(self, action: #selector(ReviewButtonTapped), for: .touchUpInside)
        likeButton = UIButton().sfImageButton(systemName: "hand.thumbsup")
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        let lowerStackView = UIStackView(arrangedSubviews: [themeButton, ReviewButton, likeButton])
        lowerStackView.translatesAutoresizingMaskIntoConstraints = false
        lowerStackView.axis = .horizontal
        lowerStackView.spacing = 32
        
        view.addSubview(lowerStackView)
        
        NSLayoutConstraint.activate([
            lowerStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            lowerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    // MARK: Impact Gesture
    func impactGesture(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactFeedback = UIImpactFeedbackGenerator(style: style)
        impactFeedback.impactOccurred()
    }
    
    
}

// MARK: Button actions
extension MainQuoteViewController {
    @objc func menuButtonTapped() {
        impactGesture(style: .rigid)
    }
    
    @objc func shareButtonTapped() {
        impactGesture(style: .rigid)
        
        let activityVC = UIActivityViewController(activityItems: [quoteController.attributedString], applicationActivities: [])
        present(activityVC, animated: true)
    }
    
    @objc func themeButtonTapped() {
        impactGesture(style: .medium)
        quoteController.quoteThemeIsActive.toggle()
        
        let buttonImageName = quoteController.quoteThemeIsActive ? "paintbrush.fill" : "paintbrush"
        let configuration = UIImage().mainViewSymbolConfig()
        let image = UIImage(systemName: buttonImageName, withConfiguration: configuration)
        themeButton.setImage(image, for: .normal)
    }
    
    @objc func ReviewButtonTapped() {
        impactGesture(style: .medium)
        
//        let layout = UICollectionViewFlowLayout()
//        let vc = QuoteReviewCollectionViewController(collectionViewLayout: layout)
//        present(vc, animated: true)
    }
    
    @objc func likeButtonTapped() {
        impactGesture(style: .medium)
        
        // add to liked and im
    }

}

