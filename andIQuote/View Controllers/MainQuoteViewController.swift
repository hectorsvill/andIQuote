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
        
        // up - share
        
        // down - comments
    }
    
    
    @objc func handleSwipeAction(_ sender: UISwipeGestureRecognizer) {
        
        if sender.direction == .left {
            quoteTextView.text = quoteController.getNextQuote().body
            

            let g = UIImpactFeedbackGenerator(style: .medium)
            g.impactOccurred()
            
        } else if sender.direction == .right {
            quoteTextView.text = quoteController.getPreviousQuote().body

            let g = UIImpactFeedbackGenerator(style: .light)
            g.impactOccurred()
        }
    }
    
    
    private func setupQuoteText() {
        quoteTextView = UITextView()
        quoteTextView.translatesAutoresizingMaskIntoConstraints = false
        quoteTextView.textAlignment = .justified
        quoteTextView.isEditable = false
        quoteTextView.isScrollEnabled = false
        
        quoteTextView.text = quoteController.quotes[0].body
        
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
        themeButton = UIButton().sfImageButton(systemName: "gear")
        commentButton = UIButton().sfImageButton(systemName: "text.bubble")
        likeButton = UIButton().sfImageButton(systemName: "hand.thumbsup")
        
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
    
    @objc func menuButtonTapped() {
        
    }
    
    @objc func shareButtonTapped() {
        
    }

}
