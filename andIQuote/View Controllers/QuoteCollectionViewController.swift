//
//  QuoteViewController.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

typealias QuoteDataSource = UICollectionViewDiffableDataSource<QuoteCollectionViewController.Section, Quote>

class QuoteCollectionViewController: UICollectionViewController {
    
    
    
    enum Section {
        case main
    }
    
    var quotes = [Quote]()
    
    private var dataSource: QuoteDataSource!
    
    var heartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        let heartImage = UIImage(systemName: "heart")
//        let heartImage = UIImage(systemName: "heart.fill")
//        button.setImage(heartImage, for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTestData()
        setupViews()
        configureDataSource()
        createSnapShot()
        print(quotes)
        
    }
    
    private func configureDataSource() {
        dataSource = QuoteDataSource(collectionView: collectionView)
            { (collectionView, indexPath, quote) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuoteCell.reuseId, for: indexPath) as? QuoteCell else { return UICollectionViewCell() }
                cell.quote = quote
                return cell
        }
    }
    
    private func createSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Quote>()
        snapShot.appendSections([.main])
        snapShot.appendItems(quotes)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    
    private func setupViews() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(QuoteCell.self, forCellWithReuseIdentifier: QuoteCell.reuseId)
        
        
        collectionView.addSubview(heartButton)
        
        let config = UIImage.SymbolConfiguration(pointSize: 45, weight: .light, scale: .large)
        let heartImage = UIImage(systemName: "heart", withConfiguration: config)
        heartButton.setImage(heartImage, for: .normal)
        
        NSLayoutConstraint.activate([
            heartButton.rightAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.rightAnchor, constant: -24),
            heartButton.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
        ])
        
        
    }
    
    
    
    

    @objc func heartButtonTapped() {
        let config = UIImage.SymbolConfiguration(pointSize: 45, weight: .medium, scale: .large)
        let heartImage = UIImage(systemName: "heart.fill", withConfiguration: config)
        heartButton.setImage(heartImage, for: .normal)
    }
    
    
}
