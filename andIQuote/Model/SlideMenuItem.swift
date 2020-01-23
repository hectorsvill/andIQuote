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
        _ = [
        SlideMenuItem(sfSymbol: "", displayText: ""),
        SlideMenuItem(sfSymbol: "house.fill", displayText: "andIQuote"),
        SlideMenuItem(sfSymbol: "hand.thumbsup.fill", displayText: "Favorites"),
        SlideMenuItem(sfSymbol: "paintbrush.fill", displayText: "Theme"),
        SlideMenuItem(sfSymbol: "bell.fill", displayText: "Reminder"),
        SlideMenuItem(sfSymbol: "plus", displayText: "Create"),
        SlideMenuItem(sfSymbol: "bookmark.fill", displayText: "I Quote"),
        SlideMenuItem(sfSymbol: "magnifyingglass", displayText: "Serach")
            ].map {slideMenuItems.append($0)}
    }
}
