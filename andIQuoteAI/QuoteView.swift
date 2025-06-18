//
//  QuoteView.swift
//  andIQuoteAI
//
//  Created by Hector Steven Villasano on 6/16/25.
//  Copyright © 2025 Hector. All rights reserved.
//

import SwiftUI

struct QuoteView: View {
    private let quote = Quote(content: "Strive not to be a success, but rather to be of value.", author: "Albert Einstein")
    private let cardWidth = UIScreen.main.bounds.width * 0.8 //80%
    
    
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<110) { index in
                        VStack {
                            // MARK: card view with transition effect
                            QuoteCardView(quote: quote)
                                .frame(width: cardWidth, height: cardWidth * 1.2) // aspect ratio
                                .containerRelativeFrame(.horizontal)
                                .scrollTransition { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1 : 0)
                                        .opacity( phase.isIdentity ? 1 : 0.6) // opacity effect
                                }
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .contentMargins(.horizontal, (UIScreen.main.bounds.width - cardWidth) / 2, for: .scrollContent)
        }
    }
}

#Preview {
    QuoteView()
}
