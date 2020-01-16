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
    
    // MARK: fetchQuotesFromFireStore
    func fetchFirstQuotes(limit: Int = 10, completion: @escaping ([QuoteDetail]?, Error?) -> ()) {
        quoteQuery.limit(to: limit).getDocuments { snapShot, error in
            if let error = error {
                completion(nil, error)
            }

            guard let snapShot = snapShot else { return }
            let quotes = self.fetchQuotesFromSnapShot(snapShot.documents)
            if let last = snapShot.documents.last {
                self.lastQueryDocumentSnapshot = last
            }
            completion(quotes, nil)
        }
    }
    
    // MARK: getNext(limit:,
    func getNext(limit: Int = 10, completion: @escaping ([Quote]?, Error?) -> ()) {
        
        guard let lastDoc = lastQueryDocumentSnapshot else { return }
        
        quoteQuery.start(atDocument: lastDoc).limit(to: limit).getDocuments { snapShot, error in
            if let error = error {
                completion(nil, error)
            }
            
            guard let snapShot = snapShot else { return }
            
            let quotes = self.fetchQuotesFromSnapShotSaveToCoreData(snapShot.documents)
            completion(quotes, nil)
            print("got netxt\n")
        }
    }
    
    // MARK: fetchQuotesFromSnapShot
    private func fetchQuotesFromSnapShot( _ documents: [QueryDocumentSnapshot]) -> [QuoteDetail] {
        var quotes = [QuoteDetail]()
        
        for doc in documents {
            let data = doc.data() as [String: Any]
            let id = data["id"] as! String
            let body = data["body"] as! String
            let author = data["author"] as! String
            let q = QuoteDetail(id: id, body: body, author: author)
            quotes.append(q)
        }
        
        return quotes
    }
    
    @discardableResult
    private func fetchQuotesFromSnapShotSaveToCoreData( _ documents: [QueryDocumentSnapshot]) -> [Quote]{
        var quotes = [Quote]()
        
        for doc in documents {
            let data = doc.data() as [String: Any]
            let id = data["id"] as! String
            let body = data["body"] as! String
            let author = data["author"] as! String
                
            let quote = Quote(body: body, author: author, id: id, like: false)
            quotes.append(quote)
            do {
                try CoreDataStack.shared.save()
                print("save")
            } catch {
                NSLog("error")
            }
        }
        return quotes
    }
}
