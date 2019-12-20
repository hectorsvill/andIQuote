//
//  QuoteViewController.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

typealias QuoteDataSource = UICollectionViewDiffableDataSource<QuoteCollectionViewController.Section, QuoteDetail>

//linehorizontal - magnifying glass

class QuoteCollectionViewController: UICollectionViewController {
    var quoteController: QuoteController!
    
    enum Section {
        case main
    }
    
    private var dataSource: QuoteDataSource!
    
    
    var clockButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.addTarget(self, action: #selector(clockButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var heartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var bubbleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.addTarget(self, action: #selector(bubbleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureDataSource()
        createSnapShot()
    }
    
    private func configureDataSource() {
        dataSource = QuoteDataSource(collectionView: collectionView) {
            (collectionView, indexPath, quote) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuoteCell.reuseId, for: indexPath) as! QuoteCell 
                
                cell.quote = quote
            
                return cell
        }
    }

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
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        
        // Clock button
        collectionView.addSubview(clockButton)
        
        let clockImage = UIImage(systemName: "clock", withConfiguration: config)
        clockButton.setImage(clockImage, for: .normal)
        
        // heart button
        let thumsupImage = UIImage(systemName: "hand.thumbsup", withConfiguration: config)
        heartButton.setImage(thumsupImage, for: .normal)
        
        // bubble button
        let bubleImage = UIImage(systemName: "text.bubble", withConfiguration: config)
        bubbleButton.setImage(bubleImage, for: .normal)

        let stackView = UIStackView(arrangedSubviews: [bubbleButton, heartButton])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        collectionView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            clockButton.topAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.topAnchor, constant: 8),
            clockButton.rightAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.rightAnchor, constant: -8),
            
            stackView.rightAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.rightAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
        ])
    
    }

    @objc func heartButtonTapped() {
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large)
        let heartImage = UIImage(systemName: "hand.thumbsup.fill", withConfiguration: config)
        heartButton.setImage(heartImage, for: .normal)
    }
    
    @objc func clockButtonTapped() {
//        let config = UIImage.SymbolConfiguration(pointSize: 45, weight: .medium, scale: .large)
//        let clockImage = UIImage(systemName: "clock.fill", withConfiguration: config)
//        clockButton.setImage(clockImage, for: .normal)
        
        let e = EKEventViewController()
        present(e, animated: true)
        
    }
    
    @objc func bubbleButtonTapped() {
    //        let config = UIImage.SymbolConfiguration(pointSize: 45, weight: .medium, scale: .large)
    //        let clockImage = UIImage(systemName: "clock.fill", withConfiguration: config)
    //        clockButton.setImage(clockImage, for: .normal)
            
        }
        
    
}


extension QuoteCollectionViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
