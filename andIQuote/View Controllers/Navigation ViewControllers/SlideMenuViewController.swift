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
    }
}

final class SlideMenuViewController: UIViewController {
    var delegateHomeControllerView: HomeControllerViewDelegate?
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

extension SlideMenuViewController {
    //MARK: createMainLayout
    private func createMainLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(74))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    // MARK: configureHierarchy
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createMainLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGray6
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.reuseIdentifier)
        view.addSubview((collectionView))
        collectionView.delegate = self
    }
    // MARK: configureDataSouce
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

extension SlideMenuViewController: UICollectionViewDelegate {
    // MARK: didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item != 0 else { return }
        delegateHomeControllerView?.handleMenuToggle(index: indexPath.item)
    }
}
