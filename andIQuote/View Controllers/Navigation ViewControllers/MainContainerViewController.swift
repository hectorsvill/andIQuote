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
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    // MARK: createFlowLayout
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }
    // MARK: configureHomeController
    func configureHomeController() {
        let homeController = QuoteCollectionViewController(collectionViewLayout: createFlowLayout())
        homeController.quoteController = quoteController
        let navigationController = UINavigationController(rootViewController: homeController)
        centerNavViewController = navigationController
        homeController.delegate = self
        view.addSubview(centerNavViewController.view)
        addChild(centerNavViewController)
        centerNavViewController.didMove(toParent: self)
    }
    // MARK:configureSlideMenuViewController
    func configureSlideMenuViewController() {
        if menuViewController == nil {
            menuViewController = SlideMenuViewController()
            menuViewController.delegateHomeControllerView = self
            menuViewController.quoteController = quoteController
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
            menuViewController.didMove(toParent: self)
        }
    }
    // MARK: showMenuController
    func showMenuController(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerNavViewController.view.frame.origin.x = self.centerNavViewController.view.frame.width / 3
            })
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerNavViewController.view.frame.origin.x = 0
            }){ _ in
                print("slide menu did end")
            }
        }
    }
}
// MARK: HomeControllerViewDelegate
extension MainContainerViewController: HomeControllerViewDelegate {
    func handleMenuToggle() {
        if !quoteController.menuNavigationIsExpanded {
            configureSlideMenuViewController()
        }
        
        quoteController.menuNavigationIsExpanded.toggle()
        showMenuController(shouldExpand: quoteController.menuNavigationIsExpanded)
    }
}
// MARK: SlideMenuEventsDelegate
extension MainContainerViewController: SlideMenuEventsDelegate {
    func handleSlideMenuEvents(_ index: Int) {
        
    }
}
