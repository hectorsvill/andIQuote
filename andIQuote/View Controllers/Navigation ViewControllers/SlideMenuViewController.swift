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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSouce()
    }
    
}

extension SlideMenuViewController {
    private func createMainLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createMainLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.setBackground(to: quoteController.background)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.reuseIdentifier)
        view.addSubview((collectionView))
        collectionView.delegate = self
    }
    
    private func configureDataSouce() {
        dataSource = dataSouceDiffable(collectionView: collectionView, cellProvider: {
            collectionView, indexPath, i -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.reuseIdentifier, for: indexPath)
            
            cell.backgroundColor = .red
            return cell
        })
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapShot.appendSections([.main])
        snapShot.appendItems(Array(0...5))
        dataSource.apply(snapShot, animatingDifferences: false)
    }
    
    
}

extension SlideMenuViewController: UICollectionViewDelegate {
    
}
