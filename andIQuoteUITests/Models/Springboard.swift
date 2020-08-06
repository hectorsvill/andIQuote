//
//  Springboard.swift
//  andIQuoteUITests
//
//  Created by Hector Villasano on 8/5/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import XCTest

class Springboard {
    let app = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    var andIQuoteIcon: XCUIElement {
        app.icons["andIQuote"]
    }
    
    var notificationShortLookView: XCUIElement {
        app.otherElements.matching(identifier: "NotificationShortLookView").element
    }
    
    var photosIcon: XCUIElement {
        app.icons["Photos"]        
    }
}
