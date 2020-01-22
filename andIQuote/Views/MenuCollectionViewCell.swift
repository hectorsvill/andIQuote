//
//  MenuCollectionViewCell.swift
//  andIQuote
//
//  Created by s on 1/19/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier = "MenuCell"
    var slideMenuItem: SlideMenuItem? { didSet { setupViews() }}
    
    private func setupViews() {
        
    }
}



