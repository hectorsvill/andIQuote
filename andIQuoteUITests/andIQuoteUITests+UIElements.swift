//
//  andIQuoteUITests+UIElements.swift
//  andIQuoteUITests
//
//  Created by Hector Villasano on 7/31/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import XCTest

extension andIQuoteUITests {
    var keyboardIsHitable: Bool {
        app.keyboards.element.isHittable
    }
    
    var isiPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var exitButton: XCUIElement {
        app.buttons["Exit"]
    }
    
    var alert: XCUIElement {
        isiPad ? app.alerts["andIQuote"] : app.sheets["andIQuote"]
    }
    
    var alertOKButton: XCUIElement {
        alert.buttons["OK"]
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
    
    var slideOutMenuCollectionView: XCUIElement {
        app.collectionViews["SlideMenuCollectionView"]
    }
    
    var slideOutMenuCollectionViewHomeCell: XCUIElement {
        slideOutMenuCollectionView.cells["Home"]
    }
    
    var slideOutMenuCollectionBookmarkedViewCell: XCUIElement {
        slideOutMenuCollectionView.cells["Bookmarked"]
    }
    
    var slideOutMenuCollectionThemeViewCell: XCUIElement {
        slideOutMenuCollectionView.cells["Theme"]
    }
    
    var slideOutMenuCollectionReminderViewCell: XCUIElement {
        slideOutMenuCollectionView.cells["Reminder"]
    }
    
    var slideOutMenuCollectionSearchViewCell: XCUIElement {
        slideOutMenuCollectionView.cells["Search"]
    }
    
    var bookmarkedQuoteCollectionViewCell: XCUIElement {
        quotesCollectionViewController.cells["QuotesViewControllerCell"]
    }
    
    var themeCollectionView: XCUIElement {
        app.collectionViews["ThemeCollectionView"]
    }
    
    func themeCollectionViewCell(with color: AppColors) -> XCUIElement {
        themeCollectionView.cells["ThemeCollectionViewCell\(color.rawValue)"]
    }
    
    var dailyReminderViewControllerStackView: XCUIElement {
        app.otherElements.matching(identifier: "DailyReminderViewControllerStackView").element
    }
    
    var dailyReminderStackViewFinishButton: XCUIElement {
        dailyReminderViewControllerStackView.buttons["DailyReminderViewControllerFinishButton"]
    }
    
    var dailyReminderViewRemindersStack: XCUIElement {
        app.otherElements.matching(identifier: "DailyReminderViewRemindersStack").element
    }
    
    var dailyReminderViewRemindersStackMinusButton: XCUIElement {
        dailyReminderViewRemindersStack.buttons["MinusButton"]
    }
    
    var dailyReminderViewRemindersStackPlussButton: XCUIElement {
        dailyReminderViewRemindersStack.buttons["PlussButton"]
    }
    
    var dailyReminderViewTimeStack: XCUIElement {
        app.otherElements.matching(identifier: "DailyReminderViewTimeStack").element
    }
    
    var dailyReminderViewTimeStackTimePicker: XCUIElement {
        dailyReminderViewTimeStack.pickers.element
    }
    
    var dailyReminderViewTimeStackTimePickerHourWheel: XCUIElement {
        dailyReminderViewTimeStackTimePicker.pickerWheels.element(boundBy: 0)
    }
    
    var dailyReminderViewTimeStackTimePickerMinuteWheel: XCUIElement {
        dailyReminderViewTimeStackTimePicker.pickerWheels.element(boundBy: 1)
    }
    
    var dailyReminderViewTimeStackTimePickerTimeConventionWheel: XCUIElement {
        dailyReminderViewTimeStackTimePicker.pickerWheels.element(boundBy: 2)
    }
    
    var searchTableView: XCUIElement {
        app.tables["SearchTableView"]
    }
    
    var searchTableViewCell: XCUIElement {
        searchTableView.cells.matching(identifier: "SearchTableViewCell").element
    }
    
    var searchViewSearchField: XCUIElement {
        app.searchFields["SearchViewSearchBar"]
    }
}

