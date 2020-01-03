//
//  MainQuoteViewController+UISwipeGestureRecognizer.swift
//  andIQuote
//
//  Created by Hector on 1/2/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit



// MARK: MainQuoteViewController + UISwipeGestureRecognizer
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
                impactGesture(style: .soft)
                quoteController.getPreviousQuote()
                quoteTextView.attributedText = quoteController.attributedString
            }
        } else {
            impactGesture(style: .medium)
            
            quoteController.getNextBackground()
            let backgroundString = quoteController.background
            if sender.direction == .left {
                setBackground(backgroundString)
            } else if sender.direction == .right {
                setBackground(backgroundString)
            }
            
            // up down for font
        }
        
        quoteController.saveQuoteIndex()
    }
    
    func setBackground(_ backgroundString: String) {
        if backgroundString ==  quoteController.backgrounds[0] {
            view.backgroundColor = .systemBackground
        } else if backgroundString ==  quoteController.backgrounds[1] {
            view.backgroundColor = .systemRed
        } else if backgroundString ==  quoteController.backgrounds[2] {
            view.backgroundColor = .systemGreen
        } else if backgroundString ==  quoteController.backgrounds[3] {
            view.backgroundColor = .systemBlue
        } else if backgroundString ==  quoteController.backgrounds[4] {
            view.backgroundColor = .systemGray
        } else if backgroundString ==  quoteController.backgrounds[5] {
            view.backgroundColor = .systemPink
        }else if backgroundString ==  quoteController.backgrounds[6] {
            view.backgroundColor = .systemTeal
        } else if backgroundString ==  quoteController.backgrounds[7] {
            view.backgroundColor = .systemIndigo
        } else if backgroundString ==  quoteController.backgrounds[8] {
            view.backgroundColor = .systemOrange
        } else if backgroundString ==  quoteController.backgrounds[9] {
            view.backgroundColor = .systemYellow
        } else if backgroundString ==  quoteController.backgrounds[10] {
            view.backgroundColor = .systemPurple
        }
        
        quoteTextView?.textColor = quoteController.background == quoteController.backgrounds[0] ? .label : .white
    }
}
