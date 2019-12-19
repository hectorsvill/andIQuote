//
//  QuoteLibrary.swift
//  andIQuote
//
//  Created by Hector on 12/18/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Foundation


struct Results: Codable, Hashable {
    let results: [QuoteDetail]
}


struct QuoteDetail: Codable, Hashable {
    let uuid = UUID().uuidString
    let body: String
    let author: String
    let tags: [String]
}
