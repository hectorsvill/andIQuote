//
//  User.swift
//  andIQuote
//
//  Created by Hector on 1/5/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation

struct User: Codable {
    let id = UUID().uuidString
    let name = ""
    let favorites: [String] = []
}
