//
//  MainContainerViewController.swift
//  andIQuote
//
//  Created by s on 1/18/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

final class MainContainerViewController: UIViewController {
    var quoteController = QuoteController()
    let userNotificationCenter = UNUserNotificationCenter.current()
    var menuViewController: SlideMenuViewController!
    var centerNavViewController: UINavigationController!
    var quoteCollectionViewController: QuoteCollectionViewController?

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
}
// MARK: HomeControllerViewDelegate
extension MainContainerViewController: HomeControllerViewDelegate {
    func handleMenuToggle(index: Int = 0) {
        if !quoteController.menuNavigationIsExpanded {
            configureSlideMenuViewController()
        }

        quoteController.menuNavigationIsExpanded.toggle()
        showMenuController(shouldExpand: quoteController.menuNavigationIsExpanded, index: index)
    }
    // MARK: showMenuController
    func showMenuController(shouldExpand: Bool, index: Int) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerNavViewController.view.frame.origin.x = self.centerNavViewController.view.frame.width / 3
            })
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerNavViewController.view.frame.origin.x = 0
            }){ _ in
                self.createView(with: index)
            }
        }
    }

    private func createView(with index: Int) {
//        impactGesture(style: .medium)
        switch index {
        case 2:
            print("favorites")
        case 3:
            print("theme")
        case 4:
            quoteCollectionViewController?.shareButtonTapped()
            let dailyReminderVC = DailyReminderViewController()
            dailyReminderVC.userNotificationCenter = userNotificationCenter
            dailyReminderVC.quoteController = quoteController
            dailyReminderVC.view.setBackground(to: quoteController.background)
            present(dailyReminderVC, animated: true)
        case 5:
            print("create")
//            let vc = UIViewController()
//            vc.view.backgroundColor = .red
//            present(vc, animated: true, completion: nil)
        case 6:
            print("my quotes")
        case 7:
            print("search")
        default:
            print("default")
        }

    }
}
extension MainContainerViewController {
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
        homeController.userNotificationCenter = userNotificationCenter
        homeController.delegate = self
        let navigationController = UINavigationController(rootViewController: homeController)
        centerNavViewController = navigationController
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

}

