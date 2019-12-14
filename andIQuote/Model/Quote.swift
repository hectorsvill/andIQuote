//
//  Quote.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Foundation


struct Quote: Hashable {
    let uuid = UUID().uuidString
    let str: String
    let heart: Bool
    let author: String?
    let hash: [String]
    
}
