//
//  andIQuoteUITests.swift
//  andIQuoteUITests
//
//  Created by Hector Villasano on 7/31/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import XCTest

class andIQuoteUITests: XCTestCase {
    let springboard = Springboard()
    var app:  XCUIApplication! = nil

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
        configureUIInterruptionMonitor()
    }
    
    private func configureUIInterruptionMonitor() {
        addUIInterruptionMonitor(withDescription: "andIQuote") { alert in
            if alert.buttons["Allow"].waitForExistence(timeout: 1) {
                alert.buttons["Allow"].tap()
            } else if alert.buttons["OK"].waitForExistence(timeout: 1){
                alert.buttons["OK"].tap()
            }
            return true
        }
    }

    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
