//
//  QuoteController.swift
//  andIQuote
//
//  Created by Hector on 12/18/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Foundation


class QuoteController {
    
    var quotes = [QuoteDetail]()
    
    init () {
        
        let url = Bundle.main.url(forResource: "QuotesLibrary", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        print(data)
        
        let decoded = try! JSONDecoder().decode(Results.self, from: data)
        print(decoded.results.count)
        quotes = decoded.results
        
    }
    
    
}
