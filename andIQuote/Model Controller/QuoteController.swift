//
//  QuoteController.swift
//  andIQuote
//
//  Created by Hector on 12/18/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit


class QuoteController {
    var quoteThemeIsActive = false // theme selecting to inactive
    var backgroundName = "systemBackground"
    var quotes = [QuoteDetail]() // list of quotes
    let backgrounds = ["systembackground", "red", "green", "blue"]
    private var _quoteIndex = 0 // current index of quote
    private var _backgroundIndex = 0
    
    var quote: QuoteDetail {
        return quotes[_quoteIndex]
    }
    
    var background: String {
        return backgrounds[_backgroundIndex]
    }
    
    var attributedString: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: quote.body, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.label])
        attributedString.append(NSAttributedString(string: "\n\n\(quote.author)", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.label]))
        return attributedString
    }
    
    init() {
        let path = Bundle.main.path(forResource: "300Quotes", ofType: "json")!
        let data = try! NSData(contentsOfFile: path) as Data
        let json = try! JSONDecoder().decode(Results.self, from: data)
        
        quotes = json.results.shuffled()
        
    }
    
    func getNextQuote() {
        _quoteIndex = _quoteIndex >= quotes.count ? 0 : _quoteIndex + 1
    }
    
    func getPreviousQuote() {
        _quoteIndex = _quoteIndex > 0 ? _quoteIndex - 1 : _quoteIndex
    }
    
    func getNextBackground() {
        _backgroundIndex = _backgroundIndex >= backgrounds.count - 1 ? 0 : _backgroundIndex + 1
    }
    
    func getPreviousBackground() {
        _backgroundIndex = _backgroundIndex > 0 ? _backgroundIndex - 1 : _backgroundIndex
    }
    
}
