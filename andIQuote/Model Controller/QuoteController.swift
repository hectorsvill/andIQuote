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
    private (set) var _quoteIndex = UserDefaults.standard.integer(forKey: "QIndex") // current index of quote
    var _backgroundIndex = UserDefaults.standard.integer(forKey: "BgIndex") // current index of background
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
    // MARK: setBackgroundIndex
    func setBackgroundIndex(_ add: Int) {
        let newValue = _backgroundIndex + add
        _backgroundIndex =  newValue > -1 && newValue < backgrounds.count ? newValue : _backgroundIndex
        UserDefaults.standard.set(_backgroundIndex, forKey: "BgIndex")
    }
    // MARK: quoteForegroundColor
    var quoteForegroundColor: UIColor {
        background == "systemBackground" ? UIColor.label : UIColor.white
    }
    // MARK: setIndex
    func setIndex(_ index: Int) {
        _quoteIndex = index
        UserDefaults.standard.set(index, forKey: "QIndex")
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
            firestore.fetchFirstQuotes { quotes, error in
                if let error = error {
                    completion(nil, error)
                }
                
                guard let quotes = quotes else { return }
                completion(quotes, nil)
                
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
        firestore.quoteQuery.start(afterDocument: firestore.lastQueryDocumentSnapshot!).limit(to: 10).getDocuments { snapShot, error in
            if let error = error {
                completion(nil, error)
            }
            
            guard let snapShot = snapShot else { return }
            
            var quotes = [Quote]()
            for doc in snapShot.documents {
                let doc  = doc.data() as [String: Any]
                let quote = Quote(data: doc)
                quotes.append(quote)
            }
            
            do {
                try CoreDataStack.shared.save()
            } catch  {
                completion(nil, error)
            }
            
            completion(quotes, nil)
        }
    }
}
