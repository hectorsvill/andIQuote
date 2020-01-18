//
//  User.swift
//  andIQuote
//
//  Created by Hector on 1/5/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation

struct QuoteUser: Codable {
    let id: String
    var name = ""
    var favorites: [String] = []
}
