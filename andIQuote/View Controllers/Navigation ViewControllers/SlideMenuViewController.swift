//
//  SlideMenuViewController.swift
//  andIQuote
//
//  Created by s on 1/18/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

typealias SlideMenuDataSouce = UICollectionViewDiffableDataSource<SlideMenuViewController.Section, SlideMenuItem>
typealias SlideSourceSnapShot = NSDiffableDataSourceSnapshot<SlideMenuViewController.Section, SlideMenuItem>

extension SlideMenuViewController {
    enum Section {
        case main
        case header
        case footer
    }
}

class SlideMenuViewController: UIViewController {
    var delegate: HomeControllerViewDelegate?
    var slideMenuItems: [SlideMenuItem] = []
    var dataSource: SlideMenuDataSouce!
    var collectionView: UICollectionView!
    var quoteController: QuoteController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSlideMenuData()
        configureHierarchy()
        configureDataSouce()
    }
}


extension SlideMenuViewController: UICollectionViewDelegate {
    enum MenuItems {
        case home, Favorites, Theme, Reminder, Create, IQuote, Search
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        
        switch row {
        case 1:
            print("Home: ", row)
            delegate?.handleMenuToggle()
//        case 1:
//        case 2:
//        case 3:
//        case 4:
            
        default:
            print(row)
        }
    }
}

extension SlideMenuViewController {
    private func createMainLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(74))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createMainLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.setBackground(to: quoteController.background)
        collectionView.backgroundColor = .systemGray6
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.reuseIdentifier)
        view.addSubview((collectionView))
        collectionView.delegate = self
    }
    
    private func configureDataSouce() {
        dataSource = SlideMenuDataSouce(collectionView: collectionView, cellProvider: { collectionView, indexPath, slideMenuItem -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.reuseIdentifier, for: indexPath) as! MenuCollectionViewCell
            cell.slideMenuItem = slideMenuItem
            return cell
        })
        
        var snapShot = SlideSourceSnapShot()
        snapShot.appendSections([.main])
        snapShot.appendItems(slideMenuItems)
        dataSource.apply(snapShot, animatingDifferences: false)
    }
}
