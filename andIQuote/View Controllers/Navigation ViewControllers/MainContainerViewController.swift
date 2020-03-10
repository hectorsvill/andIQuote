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
    var quotesViewController = QuotesViewController()

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
}

extension MainContainerViewController {
    // MARK: configureHomeController
    func configureHomeController() {
        quotesViewController.quoteController = quoteController
        quotesViewController.delegate = self
        quotesViewController.userNotificationCenter = userNotificationCenter
        centerNavViewController = UINavigationController(rootViewController: quotesViewController)
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
                self.centerNavViewController.view.frame.origin.x = self.centerNavViewController.view.frame.width / 2.5
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
        view.impactGesture(style: .medium)
        switch index {
        case 2:
            quotesViewController.quoteController.bookmarkViewIsActive = true
            quotesViewController.fetchBookmarked()
        case 3:
            quoteController.bookmarkViewIsActive = false
            quotesViewController.presentThemeView()
        case 4:
            quoteController.bookmarkViewIsActive = false
            quotesViewController.pressentReminderView()
        case 5:
            print("create")
        case 6:
            print("my quotes")
        case 7:
            print("search")
        default:
            quoteController.bookmarkViewIsActive = false
            quotesViewController.fetchAllQuotes()
        }

    }
}

