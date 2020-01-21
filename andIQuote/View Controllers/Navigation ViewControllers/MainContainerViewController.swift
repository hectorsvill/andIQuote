//
//  MainContainerViewController.swift
//  andIQuote
//
//  Created by s on 1/18/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class MainContainerViewController: UIViewController {
    var quoteController = QuoteController()
    var menuViewController: SlideMenuViewController!
    var centerNavViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    
    func configureHomeController() {
        let homeController = QuoteCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        homeController.quoteController = quoteController
        centerNavViewController = UINavigationController(rootViewController: homeController)
        homeController.delegate = self
        view.addSubview(centerNavViewController.view)
        addChild(centerNavViewController)
        centerNavViewController.didMove(toParent: self)
    }
    
    func configureMenuViewController() {
        if menuViewController == nil {
            menuViewController = SlideMenuViewController()
            menuViewController.quoteController = quoteController
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            menuViewController.didMove(toParent: self)
        }
    }
    
    func showMenuController(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerNavViewController.view.frame.origin.x = self.centerNavViewController.view.frame.width - 80
            })
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerNavViewController.view.frame.origin.x = 0
            })
        }
    }
}

// MARK: HomeControllerViewDelegate
extension MainContainerViewController: HomeControllerViewDelegate {
    func handleMenuToggle() {
        if !quoteController.menuNavigationIsExpanded {
            configureMenuViewController()
        }
        
        quoteController.menuNavigationIsExpanded.toggle()
        showMenuController(shouldExpand: quoteController.menuNavigationIsExpanded)
    }
}
