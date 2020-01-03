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
    var index = 0 // current index of quote
    
    var quote: QuoteDetail {
        return quotes[index]
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
        index += 1
    }
    
    func getPreviousQuote() {
        index = index > 0 ? index - 1 : index
    }
    
}
