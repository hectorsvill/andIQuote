//
//  SlideMenuViewController.swift
//  andIQuote
//
//  Created by s on 1/18/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

typealias dataSouceDiffable = UICollectionViewDiffableDataSource<SlideMenuViewController.Section, Int>

class SlideMenuViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: dataSouceDiffable!
    var collectionView: UICollectionView!
    
    var quoteController: QuoteController!
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

