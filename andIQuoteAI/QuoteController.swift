//
//  QuoteController.swift
//  andIQuoteAI
//
//  Created by Hector Steven Villasano on 6/18/25.
//  Copyright © 2025 Hector. All rights reserved.
//

import SwiftUI
import OSLog

@MainActor
class QuoteController: ObservableObject {
    @Published var quotes = [QuoteDetail]()	
    @AppStorage("backgroundIndex") var backgroundIndex = 0
    let logger = Logger(subsystem: "com.hectorsvill.andIQuoteAI", category: "main")
    
    init() {
        logger.info("backgroundIndex: \(self.backgroundIndex)")
        fetchQuote()
    }
    
    func fetchQuote() {	
        // fectch quote
        let sampleQuotes: [QuoteDetail] = [
            QuoteDetail(id: UUID(), content: "The quiet whisper of dawn holds more wisdom than a thousand shouted truths.", author: "Elara Vance"),
            QuoteDetail(id: UUID(), content: "In the tapestry of life, every loose thread tells a story of resilience.", author: "Marcus Thorne"),
            QuoteDetail(id: UUID(), content: "Stars are but scattered dreams, waiting for us to piece them back into constellations.", author: "Lyra Sterling"),
            QuoteDetail(id: UUID(), content: "A journey of introspection often reveals the most astonishing landscapes within.", author: "Dr. Silas Croft"),
            QuoteDetail(id: UUID(), content: "Innovation is not just about new ideas, but about seeing old problems with fresh eyes.", author: "Ava Chen"),
            QuoteDetail(id: UUID(), content: "The echo of kindness resonates far longer than any fleeting melody.", author: "Bram Hollow"),
            QuoteDetail(id: UUID(), content: "To truly listen is to open a door to understanding, even when words are unspoken.", author: "Lena Petrova"),
            QuoteDetail(id: UUID(), content: "Every sunset is an invitation to pause, reflect, and prepare for the next sunrise.", author: "Kai Solaris"),
            QuoteDetail(id: UUID(), content: "Courage isn't the absence of fear, but the decision to act despite it.", author: "Captain Anya Sharma"),
            QuoteDetail(id: UUID(), content: "The best stories are not written, but lived, one extraordinary moment at a time.", author: "Finnian O'Malley")
        ]
        
        self.quotes = sampleQuotes
        logger.info("Qupte fetched: | \(self.quotes.count) |")
    }
}
