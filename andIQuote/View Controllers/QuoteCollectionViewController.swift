//
//  QuoteViewController.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit


typealias QuoteDataSource = UICollectionViewDiffableDataSource<QuoteCollectionViewController.Section, QuoteDetail>

class QuoteCollectionViewController: UICollectionViewController {
    let quoteController = QuoteController()
    
    enum Section {
        case main
    }
    
    private var dataSource: QuoteDataSource!
    
    var heartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureDataSource()
        createSnapShot()
    }
    
    private func configureDataSource() {
        dataSource = QuoteDataSource(collectionView: collectionView)
            { (collectionView, indexPath, quote) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuoteCell.reuseId, for: indexPath) as! QuoteCell 
                
                cell.quote = quote
                return cell
        }
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        coordinator.animate(alongsideTransition: { (_) in
//            self.collectionViewLayout.invalidateLayout()
//            print("hrerherher")
//        })
//    }
//
    private func createSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, QuoteDetail>()
        snapShot.appendSections([.main])
        snapShot.appendItems(quoteController.quotes)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    
    private func setupViews() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(QuoteCell.self, forCellWithReuseIdentifier: QuoteCell.reuseId)
        
        collectionView.isPagingEnabled = true
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


extension QuoteCollectionViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
