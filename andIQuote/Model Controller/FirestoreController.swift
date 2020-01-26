//
//  FirestoreController.swift
//  andIQuote
//
//  Created by h on 1/7/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation
import Firebase

class FirestoreController {
    var lastQueryDocumentSnapshot: QueryDocumentSnapshot?
    let db = Firestore.firestore()
    
    var quoteQuery: Query {
        db.collectionGroup("quotes")
    }
    
    init() {
        getLastDocumentSnapShot()
    }
}
extension FirestoreController {
    // MARK: fetchQuotesFromFireStore
    func fetchFirstQuotes(limit: Int = 100, completion: @escaping ([Quote]?, Error?) -> ()) {
        quoteQuery.limit(to: limit).getDocuments { snapShot, error in
            if let error = error {
                completion(nil, error)
            }

            guard let snapShot = snapShot else { return }
            
            let quotes = self.fetchQuotesFromSnapShotSaveToCoreData(snapShot.documents)

            
            if let last = snapShot.documents.last {
                self.lastQueryDocumentSnapshot = last
            }
            
            completion(quotes, nil)
        }
    }
    // MARK: getNext(limit:,
    func getNext(limit: Int = 100, completion: @escaping ([Quote]?, Error?) -> ()) {
        guard let lastDoc = lastQueryDocumentSnapshot else { return }
        quoteQuery.start(atDocument: lastDoc).limit(to: limit).getDocuments { snapShot, error in
            if let error = error {
                completion(nil, error)
            }
            
            guard let snapShot = snapShot else { return }
            self.lastQueryDocumentSnapshot = snapShot.documents.last!
            let quotes = self.fetchQuotesFromSnapShotSaveToCoreData(snapShot.documents)
            completion(quotes, nil)
            print("got netxt\n")
        }
    }
    // MARK: fetchQuotesFromSnapShotSaveToCoreData
    @discardableResult
    private func fetchQuotesFromSnapShotSaveToCoreData( _ documents: [QueryDocumentSnapshot]) -> [Quote]{
        var quotes = [Quote]()
        
        for doc in documents {
            let data = doc.data() as [String: Any]
            let quote = Quote(data: data)
            quotes.append(quote)
        }
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("error")
        }
        
        return quotes
    }
    
    // MARK: getLastDocumentSnapShot
    private func getLastDocumentSnapShot() {
        Firestore.firestore().disableNetwork { error in
            self.quoteQuery.limit(to: 100).getDocuments { snapShot, error in
                if let error = error {
                    print(error)
                }
                
                guard let documents = snapShot?.documents else { return }
                if let last = documents.last {
                    self.lastQueryDocumentSnapshot = last
                }
            }
        }
                
        Firestore.firestore().enableNetwork()
    }
}
