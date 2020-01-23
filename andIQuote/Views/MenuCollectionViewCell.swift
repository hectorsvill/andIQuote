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
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let labelText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private func setupViews() {
//        layer.cornerRadius = 2
//        layer.borderWidth = 1
        
        labelText.text = slideMenuItem?.displayText
        imageView.image = UIImage(systemName: slideMenuItem!.sfSymbol, withConfiguration: UIImage().mainViewSymbolConfig())
        addSubview(imageView)
        addSubview(labelText)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            imageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            labelText.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            labelText.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelText.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}



