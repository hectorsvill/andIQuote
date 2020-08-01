//
//  andIQuoteUITests+Test.swift
//  andIQuoteUITests
//
//  Created by Hector Villasano on 7/31/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import XCTest

extension andIQuoteUITests {
    func testAppNavigationBar() throws {
        XCTAssert(appNavigationBar.isHittable)
    }
    
    func testLeftslideoutmenubarbuttonitemButton() throws {
        XCTAssert(leftSlideoutmenubarbuttonitemButton.isHittable)
    }
    
    func testQuoteViewControllerIsHittable() throws {
        XCTAssert(quotesCollectionViewController.isHittable)
    }
    
    func testQuotesCollectionViewControllerCellIsHittable() throws {
        XCTAssert(quotesCollectionViewControllerCell.isHittable)
    }
    
    func testView100QuotesAutomation() {
        for _ in 1...100 {
            XCTAssert(quotesCollectionViewControllerCell.isHittable)
            app.swipeLeft()
        }
    }
    
    func testQuotesCollectionViewControllerCellShareButtonIsHittable() throws {
        XCTAssert(quotesCollectionViewControllerCellShareButton.isHittable)
    }
    
    func testQuotesCollectionViewControllerCellBookmarkIsHittable() throws {
        XCTAssert(quotesCollectionViewControllerCellBookmark.isHittable)
    }

    func testQuotesCollectionViewControllerCellBookmarkFillIsHittable() throws {
        quotesCollectionViewControllerCellBookmark.tap()
        XCTAssert(quotesCollectionViewControllerCellBookmarkFill.isHittable)
        quotesCollectionViewControllerCellBookmarkFill.tap()
        XCTAssert(quotesCollectionViewControllerCellBookmark.isHittable)
    }
    
    func testLeftRightSwipes() throws {
        app.swipeLeft()
        XCTAssert(quotesCollectionViewControllerCell.isHittable)
        app.swipeRight()
        XCTAssert(quotesCollectionViewControllerCell.isHittable)
    }
    
    func testUIActivityContentViewIsHittable() throws {
        quotesCollectionViewControllerCellShareButton.tap()
        try uiActivityContentViewIsHittableFlow()
    }
    
    func testSwipeUPresentsUIActivityContentViewIsHittable() throws {
        app.swipeUp()
        try uiActivityContentViewIsHittableFlow()
    }
    
    func testSlideOutMenuCollectionViewAniamation() throws {
        try navigateToSlideOutManue()
        leftSlideoutmenubarbuttonitemButton.tap()
        XCTAssertFalse(slideOutMenuCollectionView.isHittable)
    }
    
    func testSlideMenuCollectionViewCellsIsHittable() throws {
        try navigateToSlideOutManue()
        XCTAssert(slideOutMenuCollectionViewHomeCell.isHittable)
        XCTAssert(slideOutMenuCollectionBookmarkedViewCell.isHittable)
        XCTAssert(slideOutMenuCollectionThemeViewCell.isHittable)
        XCTAssert(slideOutMenuCollectionReminderViewCell.isHittable)
        XCTAssert(slideOutMenuCollectionSearchViewCell.isHittable)
    }
}

extension andIQuoteUITests {
    private func uiActivityContentViewIsHittableFlow() throws {
        XCTAssert(activityContentViewNavigationBar.isHittable)
        
        if isiPad {
            app.tap()
            XCTAssertFalse(activityContentViewNavigationBar.waitForExistence(timeout: 1))
        } else {
            XCTAssert(activityContentViewNavigationBarCloseButton.isHittable)
            activityContentViewNavigationBarCloseButton.tap()
        }
    }
    
    private func navigateToSlideOutManue() throws {
        try testLeftslideoutmenubarbuttonitemButton()
        leftSlideoutmenubarbuttonitemButton.tap()
        XCTAssert(slideOutMenuCollectionView.isHittable)
    }
    
}
