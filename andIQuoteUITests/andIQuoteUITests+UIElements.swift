//
//  andIQuoteUITests+UIElements.swift
//  andIQuoteUITests
//
//  Created by Hector Villasano on 7/31/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import XCTest

extension andIQuoteUITests {
    var quotesCollectionViewController: XCUIElement {
        app.collectionViews["QuotesViewController"]
    }
    
    var appNavigationBar: XCUIElement {
        app.navigationBars["andIQuote.QuotesView"]
    }
    
    var leftSlideoutmenubarbuttonitemButton: XCUIElement {
        appNavigationBar.buttons["leftSlideOutMenuBarButtonItem"]
    }
}
