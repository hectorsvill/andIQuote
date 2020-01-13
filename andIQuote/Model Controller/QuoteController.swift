//
//  QuoteController.swift
//  andIQuote
//
//  Created by Hector on 12/18/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit
import Firebase


class QuoteController {
    let firestore = FirestoreController()
    
    var quoteThemeIsActive = false // theme selecting to inactive
    var quotes = [QuoteDetail]() // list of quotes
    let backgrounds = ["green", "blue", "gray", "pink", "red", "teal", "indigo", "orange", "yellow", "purple", "systemBackground"]
    private var _quoteIndex = 0//UserDefaults().integer(forKey: "QIndex") // current index of quote
    private var _backgroundIndex = UserDefaults().integer(forKey: "BgIndex") // current index of background
    
    var favorites = [String]() //: [String] = UserDefaults().array(forKey: "FavoriteList") as? [String] ?? []
    
    init() {
        
    }
}

extension QuoteController {
    var quote: QuoteDetail {
        return quotes[_quoteIndex]
    }
    
    var background: String {
        return backgrounds[_backgroundIndex]
    }
    
    var quoteForegroundColor: UIColor {
        return background == "systemBackground" ? UIColor.label : UIColor.white
    }
    
    var attributedString: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: quote.body, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: quoteForegroundColor])
        attributedString.append(NSAttributedString(string: "\n\n\(quote.author)", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: quoteForegroundColor]))
        return attributedString
    }
    
    func fetchQuote(completion: @escaping () -> ())  {
        firestore.fetchQuotesFromFireStore(limit: 10) { quotes, error in
            guard let quotes = quotes else { return }
            self.quotes = quotes
            completion()
        }
        
    }
    
    func getNextQuote() {
        _quoteIndex = _quoteIndex >= quotes.count - 1 ? 0 : _quoteIndex + 1
        if _quoteIndex % 7 == 0 {
            firestore.getNext { quotes, error in
                if let error = error {
                    NSLog("\(error)")
                }
                
                guard let quotes = quotes else { return }
                
                for q in quotes {
                    self.quotes.append(q)
                }
            }
        }
    }
    
    func getPreviousQuote() {
        _quoteIndex = _quoteIndex > 0 ? _quoteIndex - 1 : quotes.count - 1
    }
    
    func getNextBackground() {
        _backgroundIndex = _backgroundIndex >= backgrounds.count - 1 ? 0 : _backgroundIndex + 1
    }
    
    func getPreviousBackground() {
        _backgroundIndex = _backgroundIndex > 0 ? _backgroundIndex - 1 : backgrounds.count - 1
    }
    
    func saveQuoteIndex() {
        UserDefaults().set(_quoteIndex, forKey: "QIndex")
    }
    
    func saveBackgroundIndex() {
        UserDefaults().set(_backgroundIndex, forKey: "BgIndex")
    }
    
    func likeButtonpressed() {
        UserDefaults().set(favorites, forKey: "FavoriteList")
    }
    
}
