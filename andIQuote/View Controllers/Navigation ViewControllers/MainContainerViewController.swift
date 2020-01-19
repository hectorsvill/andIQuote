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
    var navigationIsExpanded = false
    var menuViewController: UIViewController!
    var centerNavViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    
    func configureHomeController() {
        let homeController = MainQuoteViewController()
        homeController.quoteController = quoteController
        centerNavViewController = UINavigationController(rootViewController: homeController)
        homeController.delegate = self
        view.addSubview(centerNavViewController.view)
        addChild(centerNavViewController)
        centerNavViewController.didMove(toParent: self)
    }
    
    func configureMenuViewController() {
        if menuViewController == nil {
            print("here")
            menuViewController = SlideMenuViewController()
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
protocol HomeControllerViewDelegate {
    func handleMenuToggle()
}

extension MainContainerViewController: HomeControllerViewDelegate {
    func handleMenuToggle() {
        if !navigationIsExpanded {
            configureMenuViewController()
        }
        
        navigationIsExpanded.toggle()
        showMenuController(shouldExpand: navigationIsExpanded)
    }
    
    
}
