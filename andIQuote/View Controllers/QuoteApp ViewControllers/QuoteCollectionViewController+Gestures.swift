//
//  QuoteCollectionViewController+Gestures.swift
//  andIQuote
//
//  Created by s on 1/29/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

extension QuoteCollectionViewController {
    // MARK: setupSwipeGestureRecognizer
    func setupSwipeGestureRecognizer() {
        leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeAction(_:)))
        leftSwipeGestureRecognizer.isEnabled = false
        leftSwipeGestureRecognizer.direction = .left
        collectionView.addGestureRecognizer(leftSwipeGestureRecognizer)


        rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeAction(_:)))
        rightSwipeGestureRecognizer.isEnabled = false
        rightSwipeGestureRecognizer.direction = .left
        collectionView.addGestureRecognizer(rightSwipeGestureRecognizer)

        upSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(shareButtonTapped))
        upSwipeGestureRecognizer.direction = .up
        collectionView.addGestureRecognizer(upSwipeGestureRecognizer)

        downSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(reminderButtonTapped))
        downSwipeGestureRecognizer.direction = .down
        collectionView.addGestureRecognizer(downSwipeGestureRecognizer)


        //        doubleTapSwipeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped(_:)))
        //        doubleTapSwipeGestureRecognizer.numberOfTapsRequired = 2
        //        collectionView.addGestureRecognizer(doubleTapSwipeGestureRecognizer)
    }

    // MARK: handleSwipeAction
    @objc private func handleSwipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .up {
            shareButtonTapped()
        }else if sender.direction == .down {
            reminderButtonTapped()
        }else if sender.direction == .left {
            if quoteController.quoteThemeIsActive {

                quoteController.setBackgroundIndex(1)
                collectionView.setBackground(to: quoteController.background)

            } else {
                handleSlideMenuToggle()
            }
        }else if sender.direction == .right {
            quoteController.setBackgroundIndex(-1)
            collectionView.setBackground(to: quoteController.background)

        }
    }





}
