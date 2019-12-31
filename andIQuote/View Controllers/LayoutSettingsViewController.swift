//
//  LayoutSettingsViewController.swift
//  andIQuote
//
//  Created by Hector on 12/30/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

class LayoutSettingsViewController: UIViewController {

    var seg: UISegmentedControl!
    let items = ["Background Images", "Text Fonts"]
    
    var collectionView: UICollectionViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        seg = UISegmentedControl(items: items)
        seg.selectedSegmentIndex = 0
        view.addSubview(seg)
        
        seg.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            seg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            seg.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            seg.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
        ])

//        collectionView = UICollectionView(frame: )
        
    }

}
