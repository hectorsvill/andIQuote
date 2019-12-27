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
    
    
    func fetchHappy(completion: @escaping (Error?) -> ()) {
        let url = URL(string: "https://quote-garden.herokuapp.com/quotes/search/happy")!
        URLSession.shared.dataTask(with: url) { data, _, error  in
            if let error = error {
                completion(error)
            }
            
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(Results.self, from: data)
                let quotes = results.results
                self.quotes = quotes.shuffled()
                print(quotes)
                completion(nil)
            }catch {
                completion(error)
                return
            }
            
        }.resume()
        
    }
    
}
