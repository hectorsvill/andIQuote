////
////  LayoutSettingsViewController.swift
////  andIQuote
////
////  Created by Hector on 12/30/19.
////  Copyright © 2019 Hector. All rights reserved.
////
//
//import UIKit
//
//fileprivate enum Section  {
//    case main
//}
//
////fileprivate typealias BackgroundDatSource = UICollectionViewDiffableDataSource<Section, Background>
//
//class ThemeSettingsCollectionViewController: UICollectionViewController {
//
//    var quoteAttrubutedString: NSAttributedString?
//    
//    private var dataSource: BackgroundDatSource!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        collectionView.backgroundColor = .systemBackground
//        collectionView.register(BackgroundCell.self, forCellWithReuseIdentifier: BackgroundCell.reuseId)
//        collectionView.isPagingEnabled = true
//        
//        configureDataSource()
//        createSnapShot()
//    }
//    
//    
//    private func configureDataSource() {
//        dataSource = BackgroundDatSource(collectionView: collectionView, cellProvider: {
//            collectionView, indexPath, background -> UICollectionViewCell? in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackgroundCell.reuseId, for: indexPath) as! BackgroundCell
//            cell.background = background
//            
//            return cell
//        })
//    }
//    
//    private func createSnapShot() {
//        
//        
//        
//    }
//    
//    
//
//}
