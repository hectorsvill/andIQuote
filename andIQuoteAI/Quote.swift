//
//  Quote.swift
//  andIQuoteAI
//
//  Created by Hector Steven Villasano on 6/16/25.
//  Copyright © 2025 Hector. All rights reserved.
//

import Foundation

struct Quote: Identifiable {
    let id: UUID = UUID()
    let content: String
    let author: String
}
