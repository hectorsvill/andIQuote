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
    
    init() {
        
        let path = Bundle.main.path(forResource: "300Quotes", ofType: "json")!
        let data = try! NSData(contentsOfFile: path) as Data
        
        let json = try! JSONDecoder().decode(Results.self, from: data)
        
        quotes = json.results
        print(json.results.count)
    }
    
}
