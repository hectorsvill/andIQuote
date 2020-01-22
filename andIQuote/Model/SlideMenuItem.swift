//
//  SlideMenuItem.swift
//  andIQuote
//
//  Created by s on 1/22/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation

struct SlideMenuItem: Hashable {
    let sfSymbol: String
    let displayText: String
}

extension SlideMenuViewController {
    func createSlideMenuData() {
        let favoriteItem = SlideMenuItem(sfSymbol: "text.bubble", displayText: "Favorites")
        slideMenuItems.append(favoriteItem)
        let themeItem = SlideMenuItem(sfSymbol: "hand.thumpsup.fill", displayText: "Theme Select")
        slideMenuItems.append(themeItem)
        let reminderItem = SlideMenuItem(sfSymbol: "bell.fill", displayText: "Reminder")
        slideMenuItems.append(reminderItem)
    }
}
