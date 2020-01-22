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
    var quoteThemeIsActive = false // theme selecting state
    var menuNavigationIsExpanded = false // menu navigations state
    let backgrounds = ["green", "blue", "gray", "pink", "red", "teal", "indigo", "orange", "yellow", "purple", "systemBackground"]
    let firestore = FirestoreController()
    private (set) var quotes = [Quote]() // list of quotes
    private (set) var _quoteIndex = UserDefaults().integer(forKey: "QIndex") // current index of quote
    private (set) var _backgroundIndex = UserDefaults().integer(forKey: "BgIndex") // current index of background
    private (set) var quoteUser: QuoteUser?

    init() {
        if let user = Auth.auth().currentUser {
            self.quoteUser = QuoteUser(id: user.uid)
            
        }
    }
    
}

extension QuoteController {
    // MARK: setIndex
    func setIndex(_ index: Int) {
        _quoteIndex = index
    }
    // MARK: background
    var background: String {
        backgrounds[_backgroundIndex]
    }
    // MARK: quoteForegroundColor
    var quoteForegroundColor: UIColor {
        background == "systemBackground" ? UIColor.label : UIColor.white
    }
    // MARK: attributedString
    func attributedString(_ quote: Quote) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: quote.body!, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: quoteForegroundColor])
        attributedString.append(NSAttributedString(string: "\n\n\(quote.author!)", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: quoteForegroundColor]))
        return attributedString
    }
    // MARK: fetchResultController
    var fetchResultController: NSFetchedResultsController<Quote> {
        let fetchRequest: NSFetchRequest<Quote> = Quote.fetchRequest()
        fetchRequest.sortDescriptors = []
        
        let moc = CoreDataStack.shared.mainContext
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "id", cacheName: nil)
        
        return fetchResultController
    }
    // MARK: fetchFireQuotes
    private func fetchFireQuotes() {
        firestore.fetchFirstQuotes { quotesDetail, error in
            if let error = error {
                NSLog("error: \(error)")
            }
            
            guard let qd = quotesDetail else { return }
            for q in qd {
                let q = Quote(body: q.body, author: q.author, id: q.id, like: false)
                self.quotes.append(q)
                            
                let moc = CoreDataStack.shared.mainContext
                try! moc.save()
            }
        }
    }
    // MARK: fetchQuotes
    func fetchQuotes(completion: @escaping (Error?) -> ())  {
        if UserDefaults().bool(forKey: "Startup") == false {
            firestore.fetchFirstQuotes { quotesDetail, error in
                if let error = error {
                    completion(error)
                }
                
                guard let quotesDetail = quotesDetail else { return }
                
                for quote in quotesDetail {
                    let quote = Quote(body: quote.body, author: quote.author, id: quote.id, like: false, context: CoreDataStack.shared.mainContext)
                    self.quotes.append(quote)
                }
                
                do {
                    try CoreDataStack.shared.save()
                    print("save")
                } catch {
                    NSLog("error")
                }
                completion(nil)
                UserDefaults().set(true, forKey: "Startup")
            }
        } else {
            fetchQuotesFromCoreData { _ , error in
                if let error = error {
                    completion(error)
                }
                
                completion(nil)
            }
        }
    }
    // MARK: fetchQuotesFromCoreData
    func fetchQuotesFromCoreData(completion: @escaping ([Quote]?, Error?) -> ()){
        let moc = CoreDataStack.shared.mainContext
        moc.performAndWait {
            let quoteFetch: NSFetchRequest<Quote> = Quote.fetchRequest()
            quoteFetch.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
                    
            do {
                _ = try moc.fetch(quoteFetch)
                let quotes = try quoteFetch.execute()
                self.quotes = quotes
                completion(quotes, nil)
                        
            }catch {
                completion(nil, error)
            }
        }
    }
    // MARK: getNextQuote
    func getNextQuote() {
        _quoteIndex = _quoteIndex < quotes.count - 1 ? _quoteIndex + 1: _quoteIndex
        
        if _quoteIndex % 7 == 0 && _quoteIndex + 10 > quotes.count {
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
}

