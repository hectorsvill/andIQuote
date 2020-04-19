//
//  ThemeViewController.swift
//  andIQuote
//
//  Created by s on 2/17/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

final class ThemeViewController: UIViewController {
    enum Section { case background, text }
    var quoteController: QuoteController!
    var delegate: ThemeViewControllerDelegate?
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil

    var selectedCell: UICollectionViewCell?

    var selectedIndex = UserDefaults.standard.integer(forKey: "ThemeViewController.selectedIndex")

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Theme"

        createCollectionView()
        setSelectedCell()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(exitView))
        navigationItem.leftBarButtonItem?.tintColor = .label
    }

    private func setSelectedCell() {
        guard let cell = collectionView.cellForItem(at: IndexPath(item: selectedIndex, section: 0)) else { return }
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.label.cgColor
        selectedCell = cell
    }

    @objc func exitView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension ThemeViewController {
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGray6
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)

        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: {[unowned self] collectionView, indexPath, i -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.setBackground(to: self.quoteController.backgrounds[indexPath.item])
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 3
            cell.layer.cornerRadius = 23
            cell.contentView.layer.cornerRadius = 3
            return cell
        })

        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapShot.appendSections([.background])
        snapShot.appendItems(Array(0..<quoteController.backgrounds.count), toSection: .background)
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
            selectedCell.layer.borderColor = UIColor.label.cgColor
        }

        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.white.cgColor
        selectedCell = cell
        selectedIndex = indexPath.item
        UserDefaults.standard.set(selectedIndex, forKey: "ThemeViewController.selectedIndex")
        delegate?.makeBackgroundChange(selectedIndex)
        dismiss(animated: true, completion: nil)
    }
}
