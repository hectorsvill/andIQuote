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
    let backgrounds = ["systemBackground", "green", "blue", "gray", "pink", "red", "teal", "indigo", "orange", "yellow", "purple",]
    let firestore = FirestoreController()
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
    // MARK: background
    var background: String {
        backgrounds[_backgroundIndex]
    }
    // MARK: quoteForegroundColor
    var quoteForegroundColor: UIColor {
        background == "systemBackground" ? UIColor.label : UIColor.white
    }
    func setIndex(_ index: Int) {
        _quoteIndex = index
        UserDefaults().set(index, forKey: "QIndex")
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
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true),]
        
        let moc = CoreDataStack.shared.mainContext
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "id", cacheName: nil)
        
        return fetchResultController
    }
    
}
// MARK: Networking
extension QuoteController {
    // MARK: fetchQuotes
    func fetchQuotes(completion: @escaping ([Quote]?, Error?) -> ())  {
        if UserDefaults().bool(forKey: "Startup") == false {
            firestore.fetchFirstQuotes { quotesDetail, error in
                if let error = error {
                    completion(nil, error)
                }
                
                guard let quotesDetail = quotesDetail else { return }
                
                var quotes = [Quote]()
                
                for quote in quotesDetail {
                    let quote = Quote(body: quote.body, author: quote.author, id: quote.id, like: false, context: CoreDataStack.shared.mainContext)
                    quotes.append(quote)
                }
                
                do {
                    try CoreDataStack.shared.save()
                    completion(quotes, nil)
                } catch {
                    completion(nil, error)
                }
                
                UserDefaults().set(true, forKey: "Startup")
            }
        } else {
            fetchQuotesFromCoreData { quotes , error in
                if let error = error {
                    completion(nil, error)
                }
                guard let quotes = quotes else { return }
                
                completion(quotes, nil)
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
                completion(quotes, nil)
                        
            }catch {
                completion(nil, error)
            }
        }
    }
    // MARK: getNextQuote
    func getNextQuote(completion: @escaping ([Quote]?, Error?) -> ()) {
        firestore.getNext { quotes, error in
            if let error = error {
                completion(nil, error)
            }else {
                guard let quotes = quotes else { return }
                completion(quotes, nil)
                
            }
        }
        
    }
}
