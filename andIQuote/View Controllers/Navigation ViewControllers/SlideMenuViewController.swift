//
//  SlideMenuViewController.swift
//  andIQuote
//
//  Created by s on 1/18/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

typealias SlideMenudataSouce = UICollectionViewDiffableDataSource<SlideMenuViewController.Section, SlideMenuItem>
typealias SlideSourceSnapShot = NSDiffableDataSourceSnapshot<SlideMenuViewController.Section, SlideMenuItem>

class SlideMenuViewController: UIViewController {
    
    enum Section {
        case main
        case header
        case footer
    }
    
    var dataSource: SlideMenudataSouce!
    var collectionView: UICollectionView!
    var quoteController: QuoteController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSouce()
    }
    
}

extension SlideMenuViewController: UICollectionViewDelegate {}

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
        collectionView.backgroundColor = .blue
        collectionView.setBackground(to: quoteController.background)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.reuseIdentifier)
        view.addSubview((collectionView))
        collectionView.delegate = self
    }
    
    private func configureDataSouce() {
        dataSource = SlideMenudataSouce(collectionView: collectionView, cellProvider: {
            collectionView, indexPath, i -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.reuseIdentifier, for: indexPath) as! MenuCollectionViewCell
//            cell.setBackground(to: self.quoteController.background)
            return cell
        })
        
        var snapShot = SlideMenu
        snapShot.appendSections([.main])
        snapShot.appendItems(Array(0...5))
        dataSource.apply(snapShot, animatingDifferences: false)
    }
    
    
}

