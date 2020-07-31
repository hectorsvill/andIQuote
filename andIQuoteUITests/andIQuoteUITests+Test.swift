//
//  andIQuoteUITests+Test.swift
//  andIQuoteUITests
//
//  Created by Hector Villasano on 7/31/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import XCTest

extension andIQuoteUITests {
    
    
    func testQuoteViewControllerIsHittable() throws {
        XCTAssert(quotesViewController.isHittable)
    }
}
