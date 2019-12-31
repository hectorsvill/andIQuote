//
//  MainQuoteViewController.swift
//  andIQuote
//
//  Created by Hector on 12/31/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

class MainQuoteViewController: UIViewController {
    var menuButton: UIButton!
    var shareButton: UIButton!
    var themeButton: UIButton!
    var commentButton: UIButton!
    var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavButtons()
        setupLayouts()
    }
    
    private func setupNavButtons() {
        let menuImage = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        let shareImage = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage().mainViewSymbolConfig())
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .label
        
    }
    
    private func setupLayouts() {
        themeButton = UIButton().sfImageButton(systemName: "gear")
        commentButton = UIButton().sfImageButton(systemName: "text.bubble")
        likeButton = UIButton().sfImageButton(systemName: "hand.thumbsup")
        
        let lowerStackView = UIStackView(arrangedSubviews: [themeButton, commentButton, likeButton])
        lowerStackView.translatesAutoresizingMaskIntoConstraints = false
        lowerStackView.axis = .horizontal
        lowerStackView.spacing = 16
        
        view.addSubview(lowerStackView)
        
        NSLayoutConstraint.activate([

            lowerStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            lowerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            
        ])
        
        
        
    }

    
    
    
    @objc func menuButtonTapped() {
        
    }
    
    @objc func shareButtonTapped() {
        
    }

}
