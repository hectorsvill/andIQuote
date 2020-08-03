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
        quotesCollectionViewControllerCell.swipeUp()
        
        try uiActivityContentViewIsHittableFlow()
    }
    
    func testSlideOutMenuCollectionViewAniamation() throws {
        try navigateToSlideOutManu()
        
        leftSlideoutmenubarbuttonitemButton.tap()
        
        XCTAssertFalse(slideOutMenuCollectionView.isHittable)
    }
    
    func testSlideMenuCollectionViewCellsIsHittable() throws {
        try navigateToSlideOutManu()
        XCTAssert(slideOutMenuCollectionViewHomeCell.isHittable)
        XCTAssert(slideOutMenuCollectionBookmarkedViewCell.isHittable)
        XCTAssert(slideOutMenuCollectionThemeViewCell.isHittable)
        XCTAssert(slideOutMenuCollectionReminderViewCell.isHittable)
        XCTAssert(slideOutMenuCollectionSearchViewCell.isHittable)
    }
    
    func testNavigateToHome() throws {
        try navigate(to: slideOutMenuCollectionViewHomeCell)
        XCTAssert(quotesCollectionViewController.isHittable)
    }
    
    func testNavigateToBookMarksWithZeroBookmarks() throws {
        try navigate(to: slideOutMenuCollectionBookmarkedViewCell)
        try alertFlow()
        XCTAssert(quotesCollectionViewControllerCell.waitForExistence(timeout: 1))
    }
    
    func testNavigateToBookmarksWithOneBookmark() throws {
        let bookMarkFillButton = bookmarkedQuoteCollectionViewCell.buttons["bookmark.fill"]
        XCTAssert(quotesCollectionViewControllerCellBookmark.isHittable)
        
        quotesCollectionViewControllerCellBookmark.tap()
        
        try navigate(to: slideOutMenuCollectionBookmarkedViewCell)
        XCTAssert(bookmarkedQuoteCollectionViewCell.waitForExistence(timeout: 1))
        XCTAssert(bookMarkFillButton.isHittable)
        
        bookMarkFillButton.tap()

        try alertFlow()
        XCTAssert(quotesCollectionViewControllerCell.waitForExistence(timeout: 1))
    }
    
    func testNavigateToThemeView() throws {
        try navigate(to: slideOutMenuCollectionThemeViewCell)
        XCTAssert(themeCollectionView.isHittable)
    }
}

extension andIQuoteUITests {
    private func alertFlow() throws {
        XCTAssert(alert.isHittable)
        XCTAssert(alertOKButton.isHittable)
        
        alertOKButton.tap()
    }
    
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
    
    private func navigateToSlideOutManu() throws {
        try testLeftslideoutmenubarbuttonitemButton()
        leftSlideoutmenubarbuttonitemButton.tap()
        XCTAssert(slideOutMenuCollectionView.isHittable)
    }
    
    private func navigate(to slideOutMenuCell: XCUIElement) throws {
        try navigateToSlideOutManu()
        XCTAssert(slideOutMenuCell.isHittable)
        slideOutMenuCell.tap()
    }
}
