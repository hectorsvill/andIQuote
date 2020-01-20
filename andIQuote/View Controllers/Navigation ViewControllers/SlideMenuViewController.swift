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
        case header
        case footer
    }
    
    var dataSource: dataSouceDiffable!
    var collectionView: UICollectionView!
    
    var quoteController: QuoteController!
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension SlideMenuViewController {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
