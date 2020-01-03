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
    
   
    override func viewDidLoad() {
           super.viewDidLoad()
           setupViews()
           configureDataSource()
           createSnapShot()
    }
    
    var squareButton: UIButton = {
           let button = UIButton()
           button.translatesAutoresizingMaskIntoConstraints = false
           button.tintColor = .label
           button.addTarget(self, action: #selector(squareButtonTapped), for: .touchUpInside)
           return button
    }()
    
    var lineButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.addTarget(self, action: #selector(lineButtonTapped), for: .touchUpInside)
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
    
    var gearButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.tintColor = .label
         button.addTarget(self, action: #selector(gearButtonTapped), for: .touchUpInside)
         return button
     }()
    
    @objc func heartButtonTapped() {
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large)
        let heartImage = UIImage(systemName: "hand.thumbsup.fill", withConfiguration: config)
        heartButton.setImage(heartImage, for: .normal)
    }
    
    
    @objc func lineButtonTapped() {
        let vc = QuoteReviewCollectionViewController()
        present(vc, animated: true, completion: nil)
    }
        
    @objc func bubbleButtonTapped() {
        let vc = QuoteReviewCollectionViewController()
        present(vc, animated: true, completion: nil)
    }
        
    @objc func squareButtonTapped() {
        let index = collectionView.contentOffset.x / collectionView.frame.size.width
        let quote = quoteController.quotes[Int(index)]
        let vc = UIActivityViewController(activityItems: [quote.body], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    
    @objc func gearButtonTapped() {
        
        let vc = ThemeSettingsCollectionViewController()
        present(vc, animated:  true)
        
        
    }
    
    private func setupViews() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(QuoteCell.self, forCellWithReuseIdentifier: QuoteCell.reuseId)
        collectionView.isPagingEnabled = true
        
        
        // configure button
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        
        // square and arrow up
        collectionView.addSubview(squareButton)
        let squareImage = UIImage(systemName: "square.and.arrow.up", withConfiguration: config)
        squareButton.setImage(squareImage, for: .normal)
        
        // line button
        collectionView.addSubview(lineButton)
        let lineImage = UIImage(systemName: "line.horizontal.3", withConfiguration: config)
        lineButton.setImage(lineImage, for: .normal)
        
        // heart button
        let thumsupImage = UIImage(systemName: "hand.thumbsup", withConfiguration: config)
        heartButton.setImage(thumsupImage, for: .normal)
        
        // bubble button
        let bubleImage = UIImage(systemName: "text.bubble", withConfiguration: config)
        bubbleButton.setImage(bubleImage, for: .normal)
        
        
        // gear button
        let gearImage = UIImage(systemName: "gear", withConfiguration: config)
        gearButton.setImage(gearImage, for: .normal)
        
        
        let lowerStackView = UIStackView(arrangedSubviews: [gearButton, bubbleButton, heartButton])
        
        lowerStackView.translatesAutoresizingMaskIntoConstraints = false
        lowerStackView.axis = .horizontal
        lowerStackView.spacing = 16
          
        collectionView.addSubview(lowerStackView)
          
        NSLayoutConstraint.activate([
            squareButton.topAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.topAnchor, constant: 8),
            squareButton.rightAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.rightAnchor, constant: -8),
              
            lineButton.topAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.topAnchor, constant: 8),
            lineButton.leftAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.leftAnchor, constant: 8),
              
            lowerStackView.rightAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.rightAnchor, constant: -8),
            lowerStackView.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
      }
}

extension QuoteCollectionViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
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
        snapShot.appendItems(self.quoteController.quotes)
        self.dataSource.apply(snapShot, animatingDifferences: true)
    }
}

