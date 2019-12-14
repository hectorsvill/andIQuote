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
        
        setupViews()
        
        
        
        
        
    }
    
    private func configureDataSource() {
        
        dataSource = QuoteDataSource(collectionView: collectionView)
            { (collectionView, indexPath, quote) -> UICollectionViewCell? in
            
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                
                
                
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        collectionView.addSubview(heartButton)
        let heartImage = UIImage(systemName: "heart")
        heartButton.setImage(heartImage, for: .normal)
        
        NSLayoutConstraint.activate([
            heartButton.rightAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.rightAnchor, constant: -24),
            heartButton.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
        ])
        
        
    }
    
    
    
    

    @objc func heartButtonTapped() {
        let heartImage = UIImage(systemName: "heart.fill")
        heartButton.setImage(heartImage, for: .normal)
    }
    
    
}
