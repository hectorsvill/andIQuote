//
//  QuoteReviewViewController.swift
//  andIQuote
//
//  Created by Hector on 12/22/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

class QuoteReviewCollectionViewController: UICollectionViewController {
    var quoteController: QuoteController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setBackground(to: quoteController.background)
    }
}
