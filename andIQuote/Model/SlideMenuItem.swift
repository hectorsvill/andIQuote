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
        SlideMenuItem(sfSymbol: "text.bubble.fill", displayText: "Favorites"),
        SlideMenuItem(sfSymbol: "hand.thumbsup.fill", displayText: "Theme Select"),
        SlideMenuItem(sfSymbol: "bell.fill", displayText: "Reminder"),
            ].map {slideMenuItems.append($0)}
    }
}
