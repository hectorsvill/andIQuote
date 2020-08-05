//
//  andIQuoteUITests+Test.swift
//  andIQuoteUITests
//
//  Created by Hector Villasano on 7/31/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import XCTest

extension andIQuoteUITests {
    func testandIQuoteIconIsHitable() throws {
        try navigateToHomeScreen()
        XCTAssert(springboard.andIQuoteIcon.isHittable)
        springboard.andIQuoteIcon.tap()
        XCTAssert(quotesCollectionViewController.waitForExistence(timeout: 1))
    }
    
    func testAppNavigationBar() throws {
        XCTAssert(appNavigationBar.isHittable)
        XCTAssert(quotesCollectionViewController.waitForExistence(timeout: 2))
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
    
    func testQuotesCollectionViewControllerCellShareButtonIsHittable() throws {
        XCTAssert(quotesCollectionViewControllerCellShareButton.isHittable)
    }
    
    func testQuotesCollectionViewControllerCellShareButtonShareImage() throws {
        let saveImageCell = app.cells["Save Image"]
        
        quotesCollectionViewControllerCellShareButton.tap()
        
        XCTAssert(activityContentViewNavigationBar.isHittable)
        XCTAssert(saveImageCell.isHittable)
        
        saveImageCell.tap()
        app.tap()
        
        try navigateToHomeScreen()
        
        if !springboard.photosIcon.isHittable {
            springboard.app.swipeRight()
        }
        
        springboard.photosIcon.tap()
    }
    
    func testQuotesCollectionViewControllerCellShareButtonCopyImageToPastBoard() throws {
        let copyeCell = app.cells["Copy"]
        
        quotesCollectionViewControllerCellShareButton.tap()
        
        XCTAssert(activityContentViewNavigationBar.isHittable)
        
        XCTAssert(copyeCell.isHittable)
        
        copyeCell.tap()
        
        XCTAssertNotNil(UIPasteboard.general.hasImages)
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
    
    func testThemeViewExitButton() throws {
        try testNavigateToThemeView()
        XCTAssert(exitButton.isHittable)
        
        exitButton.tap()
        
        XCTAssert(quotesCollectionViewControllerCell.waitForExistence(timeout: 1))
    }
    
    func testThemeCollectionViewCellColorsIsHitable() throws {
        try testNavigateToThemeView()
        
        for color in AppColors.allCases {
            XCTAssert(themeCollectionViewCell(with: color).isHittable)
        }
    }
        
    func testSetThemeColorToSystem() throws {
        try setTheme(to: .Systembackground)
    }
    
    func testSetThemeColorToGreen() throws {
        try setTheme(to: .Green)
    }
    
    func testSetThemeColorToBlue() throws {
        try setTheme(to: .Blue)
    }
    
    func testSetThemeColorToGray() throws {
        try setTheme(to: .Gray)
    }
    
    func testSetThemeColorToPink() throws {
        try setTheme(to: .Pink)
    }
    
    func testSetThemeColorToRed() throws {
        try setTheme(to: .Red)
    }
    
    func testSetThemeColorToTeal() throws {
        try setTheme(to: .Teal)
    }
    
    func testSetThemeColorToIndigo() throws {
        try setTheme(to: .Indigo)
    }
    
    func testSetThemeColorToOrange() throws {
        try setTheme(to: .Orange)
    }
    
    func testSetThemeColorToYellow() throws {
        try setTheme(to: .Yellow)
    }
    
    func testSetThemeColorToPurple() throws {
        try setTheme(to: .Purple)
    }
    
    func testNavigateToRemindersView() throws {
        try navigate(to: slideOutMenuCollectionReminderViewCell)
        XCTAssert(dailyReminderViewControllerStackView.isHittable)
        app.tap() // to handle interruption monitor
    }
    
    func testRemindersViewStackStaticTextIsHittable() throws {
        try testNavigateToRemindersView()
        XCTAssert(dailyReminderViewControllerStackView.staticTexts["Reminders:"].isHittable)
        XCTAssert(dailyReminderViewControllerStackView.staticTexts["Time:"].isHittable)
        XCTAssert(dailyReminderViewControllerStackView.staticTexts["Sound:"].isHittable)
    }
    
    func testReminderViewReminderStackIsHittable() throws {
        try testNavigateToRemindersView()
        XCTAssert(dailyReminderViewRemindersStack.isHittable)
        XCTAssert(dailyReminderViewRemindersStackMinusButton.isHittable)
        XCTAssert(dailyReminderViewRemindersStackPlussButton.isHittable)
    }
    
    func testReminderViewTimeStackIsHittable() throws {
        try testNavigateToRemindersView()
        XCTAssert(dailyReminderViewTimeStack.isHittable)
        XCTAssert(dailyReminderViewTimeStackTimePicker.isHittable)
        XCTAssert(dailyReminderViewTimeStackTimePickerHourWheel.isHittable)
        XCTAssert(dailyReminderViewTimeStackTimePickerMinuteWheel.isHittable)
        XCTAssert(dailyReminderViewTimeStackTimePickerTimeConventionWheel.isHittable)
    }
    
    func testReminderViewSoundStackIsHittable() throws {
        try testNavigateToRemindersView()
        XCTAssert(dailyReminderViewSoundStack.isHittable)
        XCTAssert(dailyReminderViewSoundStackMinusButton.isHittable)
        XCTAssert(dailyReminderViewRemindersStackPlussButton.isHittable)
    }
    
    func testRemindersViewsFinishButton() throws {
        try testNavigateToRemindersView()
        XCTAssert(dailyReminderStackViewFinishButton.isHittable)
        
        dailyReminderStackViewFinishButton.tap()
        
        XCTAssertFalse(dailyReminderViewControllerStackView.waitForExistence(timeout: 1))
    }
    
    func testReminderViewSetReminderTo60SecondsFromNow() throws {
        let timeInSeconds: Double = 60
        
        try testNavigateToRemindersView()
        try remindersViewSetReminder(to: timeInSeconds)
        try navigateToHomeScreen()
        
        XCTAssert(springboard.notificationShortLookView.waitForExistence(timeout: timeInSeconds + 10))
        
        springboard.notificationShortLookView.tap()
        
        XCTAssert(quotesCollectionViewController.waitForExistence(timeout: 1))
    }
    
    func testNavigateToSearchView() throws {
        try navigate(to: slideOutMenuCollectionSearchViewCell)
        XCTAssert(searchTableView.isHittable)
    }
    
    func testSearchViewExitButton() throws {
        try testNavigateToSearchView()
        XCTAssert(exitButton.isHittable)
        
        exitButton.tap()
        
        XCTAssertFalse(searchTableView.waitForExistence(timeout: 1))
    }
    
    func testSearchViewSearhFieldIsHittable() throws {
        try testNavigateToSearchView()
        XCTAssert(searchViewSearchField.isHittable)
        
        searchViewSearchField.tap()
    }
    
    func testSearchViewTapSearchFieldKeyboardIsHitable() throws {
        try testSearchViewSearhFieldIsHittable()
        
        searchViewSearchField.tap()
        
        XCTAssert(keyboardIsHitable)
    }
    
    func testSearchViewSearch() throws {
        try searchViewSearchField(search: .Buddha)
    }
}

extension andIQuoteUITests {
    private func navigateToHomeScreen() throws {
        XCUIDevice.shared.press(XCUIDevice.Button.home)
    }
    
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
    
    private func setTheme(to color: AppColors) throws {
        let themeCollectionViewCellColor = themeCollectionViewCell(with: color)
        try testNavigateToThemeView()
        XCTAssert(themeCollectionViewCellColor.isHittable)
        
        themeCollectionViewCellColor.tap()
        
        XCTAssert(quotesCollectionViewControllerCell.waitForExistence(timeout: 1))
    }
    
    private func searchViewSearchField(search searchName: SearchNames) throws {
        try testSearchViewSearhFieldIsHittable()
        try keyboardHandler(searchName.rawValue)
        
        if searchTableViewCell.waitForExistence(timeout: 1) {
            searchTableViewCell.tap()
        }
    }
    
    private func keyboardHandler(_ string: String) throws {
        for character in string.capitalized {
            let character = String(character)
            let key = character == " " ? app.keys["space"] : app.keys[character]
            
            if !key.waitForExistence(timeout: 1) {
                isiPad ? (app.keys["shift"].tap()) : (app.buttons["shift"].tap())
            }
            
            XCTAssert(key.isHittable)
            
            key.tap()
        }
    }
    
    private func remindersViewSetReminder(to timeInSeconds: Double) throws  {
        let notificationDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970 + timeInSeconds)
        
        dailyReminderViewRemindersStackPlussButton.tap()
    
        try dailyReminderViewTimeStackTimePickerAdjust(with: notificationDate)
        
        dailyReminderViewSoundStackPlusButton.tap()
        dailyReminderStackViewFinishButton.tap()
    }
    
    private func dailyReminderViewTimeStackTimePickerAdjust(with date: Date) throws {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let hourString = hour <= 12 ? String(hour) : String(hour - 12)
        
        let minute = calendar.component(.minute, from: date)
        let minuteString = minute <= 9 ? "0\(minute)" : "\(minute)"
        let timeConvetionString = hour >= 12 ? "PM" : "AM"

        XCTAssert(dailyReminderViewTimeStackTimePickerHourWheel.isHittable)
        dailyReminderViewTimeStackTimePickerHourWheel.adjust(toPickerWheelValue: hourString)
        
        XCTAssert(dailyReminderViewTimeStackTimePickerMinuteWheel.isHittable)
        dailyReminderViewTimeStackTimePickerMinuteWheel.adjust(toPickerWheelValue: minuteString)
        
        XCTAssert(dailyReminderViewTimeStackTimePickerTimeConventionWheel.isHittable)
        dailyReminderViewTimeStackTimePickerTimeConventionWheel.adjust(toPickerWheelValue: timeConvetionString)
    }
}
