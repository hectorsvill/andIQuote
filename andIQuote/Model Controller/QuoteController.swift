//
//  QuoteController.swift
//  andIQuote
//
//  Created by Hector on 12/18/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import CoreData
import UIKit
import Firebase

class QuoteController {
    let firestore = FirestoreController()
    
    var quoteThemeIsActive = false // theme selecting to inactive
    var quotes = [Quote]() // list of quotes
    let backgrounds = ["green", "blue", "gray", "pink", "red", "teal", "indigo", "orange", "yellow", "purple", "systemBackground"]
    var _quoteIndex = UserDefaults().integer(forKey: "QIndex") // current index of quote
    
    var _backgroundIndex = UserDefaults().integer(forKey: "BgIndex") // current index of background
    
    var favorites = [String]() //: [String] = UserDefaults().array(forKey: "FavoriteList") as? [String] ?? []
    
    init() {
        print(_quoteIndex)
        
        
        
    }
}

extension QuoteController {
    var quote: Quote {
        quotes[_quoteIndex]
    }
    
    var background: String {
        backgrounds[_backgroundIndex]
    }
    
    var quoteForegroundColor: UIColor {
        background == "systemBackground" ? UIColor.label : UIColor.white
    }
    
    var attributedString: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: quote.body!, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: quoteForegroundColor])
        attributedString.append(NSAttributedString(string: "\n\n\(quote.author!)", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: quoteForegroundColor]))
        return attributedString
    }
    
    var fetchResultController: NSFetchedResultsController<Quote> {
        let fetchRequest: NSFetchRequest<Quote> = Quote.fetchRequest()
        fetchRequest.sortDescriptors = []
        
        let moc = CoreDataStack.shared.mainContext
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "id", cacheName: nil)
        
        return fetchResultController
    }
    
    func fetchQuotes(completion: @escaping (Error?) -> ())  {
        firestore.fetchQuotesFromFireStore { quotes, error in
            if let error = error {
                completion(error)
            }
            guard let quotes = quotes else { return }
            print(quotes)
            for q in quotes {
                let q = Quote(body: q.body, author: q.author, id: q.id, like: false)
                self.quotes.append(q)
                
                let moc = CoreDataStack.shared.mainContext
                try! moc.save()
            }
            
            completion(nil)
            
        }
        
        
        
//        do {
//            try fetchResultController.performFetch()
//        }catch {
//            completion(nil, error)
//        }
//
//       if let _ = fetchResultController.fetchedObjects {
//
//       } else {
//            NSLog("!!objects are empty!!!!")
//            firestore.fetchQuotesFromFireStore(limit: 10) { error in
//                if let error = error {
//                    completion(nil, error)
//                }
//
//            }
//
//            do {
//                try fetchResultController.performFetch()
//            }catch {
//                completion(nil, error)
//            }
//            return
//        }
//
//        guard let fetchedObjects = fetchResultController.fetchedObjects else { return }
//
//
//        DispatchQueue.main.async {
//            self.quotes = fetchedObjects
//            completion(self.quote, nil)
//        }
        
    }
    
    func getNextQuote() {
        _quoteIndex = _quoteIndex >= quotes.count - 1 ? 0 : _quoteIndex + 1
       
        if _quoteIndex % 7 == 0 {
            firestore.getNext { error in
                if let error = error {
                    NSLog("\(error)")
                }
                
//                guard let quotes = quotes else { return }
//                
//                for q in quotes {
//                    self.quotes.append(q)
//                }
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

