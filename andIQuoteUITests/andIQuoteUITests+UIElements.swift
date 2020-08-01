//
//  andIQuoteUITests+UIElements.swift
//  andIQuoteUITests
//
//  Created by Hector Villasano on 7/31/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import XCTest

extension andIQuoteUITests {
    var isiPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var quotesCollectionViewController: XCUIElement {
        app.collectionViews["QuotesViewController"]
    }
    
    var appNavigationBar: XCUIElement {
        app.navigationBars["andIQuote.QuotesView"]
    }
    
    var leftSlideoutmenubarbuttonitemButton: XCUIElement {
        appNavigationBar.buttons["leftSlideOutMenuBarButtonItem"]
    }
    
    var quotesCollectionViewControllerCell: XCUIElement {
        quotesCollectionViewController.scrollViews.children(matching: .cell).matching(identifier: "QuotesViewControllerCell").element(boundBy: 1)
    }
    
    var quotesCollectionViewControllerCellShareButton: XCUIElement {
        quotesCollectionViewControllerCell.buttons["Share"]        
    }
    
    var quotesCollectionViewControllerCellBookmark: XCUIElement {
        quotesCollectionViewControllerCell.buttons["bookmark"]
    }
    
    var quotesCollectionViewControllerCellBookmarkFill: XCUIElement {
        quotesCollectionViewControllerCell.buttons["bookmark.fill"]
    }
    
    var activityContentViewNavigationBar: XCUIElement {
        app.navigationBars["UIActivityContentView"]
    }
    
    var activityContentViewNavigationBarCloseButton: XCUIElement {
        activityContentViewNavigationBar.buttons["Close"]
    }
}
