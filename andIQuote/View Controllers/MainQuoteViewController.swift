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
    var commentButton: UIButton!
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
    
    private func setupGestureRecogniser() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeAction(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeAction(_:)))
        rightSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(shareButtonTapped))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(commentButtonTapped))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
    }
    
    @objc func handleSwipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            impactGesture(style: .light)
            quoteController.getNextQuote()
            quoteTextView.attributedText = quoteController.attributedString
        } else if sender.direction == .right {
            impactGesture(style: .soft)
            quoteController.getPreviousQuote()
            quoteTextView.attributedText = quoteController.attributedString
        }
    }
    
    
    private func setupQuoteText() {
        quoteTextView = UITextView()
        quoteTextView.translatesAutoresizingMaskIntoConstraints = false
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
        commentButton = UIButton().sfImageButton(systemName: "text.bubble")
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        likeButton = UIButton().sfImageButton(systemName: "hand.thumbsup")
        likeButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        
        let lowerStackView = UIStackView(arrangedSubviews: [themeButton, commentButton, likeButton])
        lowerStackView.translatesAutoresizingMaskIntoConstraints = false
        lowerStackView.axis = .horizontal
        lowerStackView.spacing = 32
        
        view.addSubview(lowerStackView)
        
        NSLayoutConstraint.activate([
            lowerStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            lowerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func impactGesture(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactFeedback = UIImpactFeedbackGenerator(style: style)
        impactFeedback.impactOccurred()
    }
    
    @objc func menuButtonTapped() {
        print("menu button tapped")
        impactGesture(style: .rigid)
        
    }
    
    @objc func shareButtonTapped() {
        print("share button")
        impactGesture(style: .rigid)
    }
    
    @objc func themeButtonTapped() {
        print("themebutton taped")
        impactGesture(style: .medium)
    }
    
    @objc func commentButtonTapped() {
        print("comments thread")
        impactGesture(style: .medium)
    }
    
    @objc func likeButtonTapped() {
        print("like button")
        impactGesture(style: .medium)
    }

}
