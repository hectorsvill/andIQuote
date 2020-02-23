//
//  ThemeViewController.swift
//  andIQuote
//
//  Created by s on 2/17/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

extension ThemeViewController {
    enum Section {
        case background
        case text
    }
}

class ThemeViewController: UIViewController {
    var quoteController: QuoteController!

    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil

    var selectedCell: UICollectionViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionView()
    }
}

extension ThemeViewController {
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)

        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { collectionView, indexPath, i -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.setBackground(to:self.quoteController.backgrounds[indexPath.item + 1])
            cell.layer.cornerRadius = 3
            cell.contentView.layer.cornerRadius = 3
            return cell
        })

        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapShot.appendSections([.background])
        snapShot.appendItems(Array(0..<quoteController.backgrounds.count - 1), toSection: .background)
        dataSource.apply(snapShot)
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.333), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.333))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }



}

extension ThemeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }

        if let selectedCell = selectedCell {
            selectedCell.layer.borderColor = UIColor.white.cgColor
        }

        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.black.cgColor
        selectedCell = cell
    }
}
