//
//  QuoteView.swift
//  andIQuoteAI
//
//  Created by Hector Steven Villasano on 6/16/25.
//  Copyright © 2025 Hector. All rights reserved.
//

import SwiftUI

struct QuoteView: View {
    let quote = Quote(content: "Strive not to be a success, but rather to be of value.", author: "Albert Einstein")
    
    var body: some View {
        
        
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<110) { index in
                        VStack {
                            // MARK: card view with transition effect
                            QuoteCardView(quote: quote)
                                .frame(width: 300)
                                .scrollTransition { content, phase in		
                                    content.scaleEffect(phase.isIdentity ? 1 : 0.8)
                                }
                            
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .contentMargins(.horizontal, (UIScreen.main.bounds.width - 300) / 2, for: .scrollContent)
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(0..<110) { index in
                    VStack {
                        // MARK: card view with transition effect
                        QuoteCardView(quote: quote)
                            .frame(width: 300)
                            .scrollTransition { content, phase in
                                content.scaleEffect(phase.isIdentity ? 1 : 0.8)
                            }
                        
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(.horizontal, (UIScreen.main.bounds.width - 300) / 2, for: .scrollContent)
    }
}

#Preview {
    QuoteView()
}
