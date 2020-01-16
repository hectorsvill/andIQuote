//
//  MainQuoteViewController+UISwipeGestureRecognizer.swift
//  andIQuote
//
//  Created by Hector on 1/2/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

extension MainQuoteViewController {
    func setupGestureRecogniser() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeAction(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeAction(_:)))
        rightSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(shareButtonTapped))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ReviewButtonTapped))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func handleSwipeAction(_ sender: UISwipeGestureRecognizer) {
        if !quoteController.quoteThemeIsActive {
            if sender.direction == .left {
                // get next quote
                impactGesture(style: .light)
                
                quoteController.getNextQuote()
                
                
                quoteTextView.attributedText = quoteController.attributedString
            } else if sender.direction == .right {
                // get previous quote
                guard quoteController._quoteIndex != 0 else { return }
                impactGesture(style: .soft)
                quoteController.getPreviousQuote()
                quoteTextView.attributedText = quoteController.attributedString
            }
            quoteController.saveQuoteIndex()
            let quoteID = quoteController.quote.id
            var buttonImageName =  "hand.thumbsup.fill"
            if !quoteController.favorites.contains(quoteID!) {
                buttonImageName =  "hand.thumbsup"
            }
            let configuration = UIImage().mainViewSymbolConfig()
            let image = UIImage(systemName: buttonImageName, withConfiguration: configuration)
            likeButton.setImage(image, for: .normal)
            
            
        } else {
            impactGesture(style: .medium)
            
            quoteController.getNextBackground()
            let backgroundString = quoteController.background
            if sender.direction == .left {
                setBackground(backgroundString)
            } else if sender.direction == .right {
                setBackground(backgroundString)
            }
        }
    }
    
    func setBackground(_ backgroundString: String) {
        view.setBackground(to: backgroundString)
        quoteTextView.textColor = quoteController.background == "systemBackground" ? .label : .white
    }
}
