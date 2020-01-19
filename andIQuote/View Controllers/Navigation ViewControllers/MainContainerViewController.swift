//
//  MainContainerViewController.swift
//  andIQuote
//
//  Created by s on 1/18/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

protocol HomeControllerViewDelegate {
    func handleMenuToggle()
}

class MainContainerViewController: UIViewController {
    
    var navigationIsExpanded = false
    var menuViewController: UIViewController!
    var centerNavViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    func configureHomeController() {
        let homeController = MainQuoteViewController()
        centerNavViewController = UINavigationController(rootViewController: homeController)
        homeController.delegate = self
        
        
    }
    
    
}

extension MainContainerViewController: HomeControllerViewDelegate {
    func handleMenuToggle() {
        
    }
    
    
}
