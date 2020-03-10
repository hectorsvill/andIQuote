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
        let list = [
            SlideMenuItem(sfSymbol: "", displayText: ""),
            SlideMenuItem(sfSymbol: "house", displayText: "andIQuote"),
            SlideMenuItem(sfSymbol: "bookmark", displayText: "Bookmarked"),
            SlideMenuItem(sfSymbol: "paintbrush", displayText: "Theme"),
            SlideMenuItem(sfSymbol: "bell", displayText: "Reminder"),
            SlideMenuItem(sfSymbol: "plus", displayText: "Create"),
            SlideMenuItem(sfSymbol: "book", displayText: "I Quote"),
            SlideMenuItem(sfSymbol: "magnifyingglass", displayText: "Serach")
        ]

        list.forEach {slideMenuItems.append($0)}
    }
}
