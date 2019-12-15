//
//  Quote.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Foundation


struct Quote: Hashable {
    let uuid = UUID().uuidString
    let str: String
    let heart = false
    let author: String?
    var hash = [String]()
    
}


extension QuoteCollectionViewController {
    
    func setupTestData() {
        let quote_list = [
            "Faith is an oasis in the heart which will never be reached by the caravan of thinking.",
            "Pride is still aiming at the best houses: Men would be angels, angels would be gods. Aspiring to be gods, if angels fell aspiring to be angels men rebel.",
            "To turn really interesting ideas and fledgling technologies into a company that can continue to innovate for years, it requires a lot of disciplines.",
        ]
        
        _ = quote_list.map { quotes.append(Quote(str: $0, author: "")) }
        
        
        
        
    }
    
    
}

