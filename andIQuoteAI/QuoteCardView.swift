//
//  QuoteCardView.swift
//  andIQuoteAI
//
//  Created by Hector Steven Villasano on 6/16/25.
//  Copyright © 2025 Hector. All rights reserved.
//

import SwiftUI

struct Quote: Identifiable {
    let id: UUID = UUID()
    let content: String
    let author: String
}

struct QuoteCardView: View {
    let quote: Quote
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .fill(Color.green)
            
            VStack(spacing: 20) {
                
                Spacer()
                
                Text("\"\(quote.content)\"")
                    .font(.system(size: 28, weight: .medium, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Text("— \(quote.author)")
                    .font(.system(size: 20, weight: .light, design: .serif))
                    .italic()
                    .foregroundColor(.white.opacity(0.9))
                
                Spacer()
                
                HStack {
                    Button(action: { print("Share button tapped") }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Button(action: { print("Favorite button tapped") }) {
                        Image(systemName: "bookmark")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .padding(.leading)
//                .background(.red)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(10)
    }
}

#Preview {
    let quote = Quote(content: "The future belongs to those who believe in the possibilities of tomorrow.", author: "Franklin D. Roosevelt")
    QuoteCardView(quote: quote)
}
