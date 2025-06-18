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
    
    @State private var fullScreenIndex: Int? = nil
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(0..<110) { index in
                            VStack {
                                // MARK: card view with transition effect
                                QuoteCardView(quote: quote, index: index) { index in
                                    self.fullScreenIndex = index
                                    
                                }
                                
                                .frame(width: cardWidth, height: cardWidth * 1.2) // aspect ratio
                                .containerRelativeFrame(.horizontal)
                                .scrollTransition { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1 : 0)
                                        .opacity( phase.isIdentity ? 1 : 1) // opacity effect
                                }
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .contentMargins(.horizontal, (UIScreen.main.bounds.width - cardWidth) / 2, for: .scrollContent)
            }
            .ignoresSafeArea(.all)
            
            if let fullScreenIndex = fullScreenIndex {
                QuoteCardView(quote: quote, index: fullScreenIndex) { _ in
                    self.fullScreenIndex = nil
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .transition(.scale)
                .onTapGesture {
                    self.fullScreenIndex = nil
                }
            }
            
        }
        .background(Color.clear)
        .ignoresSafeArea(.all)

    }
   
}

#Preview {
    QuoteView()
}
