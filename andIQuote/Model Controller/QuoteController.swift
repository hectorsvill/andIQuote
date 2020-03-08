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
    var quotes = [Quote]()

    var quoteThemeIsActive = false // theme selecting state
    var menuNavigationIsExpanded = false // menu navigations state

    private (set) var _quoteIndex = UserDefaults.standard.integer(forKey: "QIndex") // current index of quote

    let backgrounds = ["systemBackground", "green", "blue", "gray", "pink", "red", "teal", "indigo", "orange", "yellow", "purple",]
    private (set) var _backgroundIndex = UserDefaults.standard.integer(forKey: "QuoteController.setBackgroundIndex") // current index of background

    private (set) var quoteUser: QuoteUser?

    var remindersCount = UserDefaults.standard.integer(forKey: "DailyReminderViewController.reminderNotificationData" + "Reminders:")
    var remindersStartTime = UserDefaults.standard.integer(forKey: "DailyReminderViewController.reminderNotificationData" + "Time:")
    var reminderTimeIntervalSeconds: Double = 3600 // 1 hour 
    var bookmarked: [String] = []

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
    // MARK: trademarkAttributedString
    var trademarkAttributedString: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "and", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.label])
        attributedString.append(NSAttributedString(string: "I", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.label]))
        attributedString.append(NSAttributedString(string: "Quote", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.label]))
        return attributedString
    }
    // MARK: setBackgroundIndex
    func setBackgroundIndex(_ index: Int) {
        _backgroundIndex = index
        UserDefaults.standard.set(_backgroundIndex, forKey: "QuoteController.setBackgroundIndex")
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
                self.quotes = quotes
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
}
