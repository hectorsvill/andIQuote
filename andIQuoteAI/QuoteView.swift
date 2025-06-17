//
//  QuoteView.swift
//  andIQuoteAI
//
//  Created by Hector Steven Villasano on 6/16/25.
//  Copyright © 2025 Hector. All rights reserved.
//

import SwiftUI

struct QuoteView: View {
    let quote = Quote(content: "Hello, World!", author: "Hector")
    var body: some View {
        QuoteCardView(quote: quote)
    }
}

#Preview {
    QuoteView()
}
