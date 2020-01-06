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
    var quotes = [QuoteDetail]() // list of quotes
    let backgrounds = ["green", "blue", "gray", "pink", "red", "teal", "indigo", "orange", "yellow", "purple", "systemBackground"]
    private var _quoteIndex = UserDefaults().integer(forKey: "QIndex") // current index of quote
    private var _backgroundIndex = UserDefaults().integer(forKey: "BgIndex") // current index of background
    
    var favorites = [String]() //: [String] = UserDefaults().array(forKey: "FavoriteList") as? [String] ?? []
    
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
    
    init() {
        let path = Bundle.main.path(forResource: "300Quotes", ofType: "json")!
        let data = try! NSData(contentsOfFile: path) as Data
        let json = try! JSONDecoder().decode(Results.self, from: data)
        
        quotes = json.results
    }
    
    func getNextQuote() {
        _quoteIndex = _quoteIndex >= quotes.count - 1 ? 0 : _quoteIndex + 1
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
