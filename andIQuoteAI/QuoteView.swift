//
//  QuoteView.swift
//  andIQuoteAI
//
//  Created by Hector Steven Villasano on 6/16/25.
//  Copyright © 2025 Hector. All rights reserved.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var quoteController = QuoteController()
    @State private var currentQuote: QuoteDetail?
    private let cardWidth = UIScreen.main.bounds.width * 0.9  //80%
    @State private var fullScreenIndex: Int? = nil
    
    var body: some View {
        ZStack {
            VStack {
                
                scrollViewReaderQuotes()
                
                if let fullScreenIndex = fullScreenIndex {
                    QuoteCardView(quote: currentQuote!, index: fullScreenIndex) { _ in
                        self.fullScreenIndex = nil
                    }
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                    )
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
    
    fileprivate func scrollViewReaderQuotes() -> ScrollViewReader<some View> {
        return ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(Array(quoteController.quotes.enumerated()), id: \.element.id) { index, quote in
                        // MARK: card view with transition effect
                        QuoteCardView(quote: quote, index: index) { index in
                            self.fullScreenIndex = index
                            self.currentQuote = quote
                        }
                        .ignoresSafeArea(.all)
                        .frame(width: cardWidth, height: cardWidth * 1.2)  // aspect ratio
                        .containerRelativeFrame(.horizontal)
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0)
                                .opacity(phase.isIdentity ? 1 : 0.9)  // opacity effect
                        }
                        
                    }
                    .scrollTargetLayout()
                }
                .ignoresSafeArea(.all)
                .scrollTargetBehavior(.viewAligned)
                .contentMargins(
                    .horizontal,
                    (UIScreen.main.bounds.width - cardWidth) / 2,for: .scrollContent
                )
            }
            .clipped()
            .ignoresSafeArea(.all)
        }
    }

}
