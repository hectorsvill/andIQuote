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
    
    // MARK: getNext(limit:,
    func getNext(limit: Int = 10, completion: @escaping (Error?) -> ()) {
        guard let lastDoc = lastQueryDocumentSnapshot else { return }
        
        quoteQuery.start(atDocument: lastDoc).limit(to: limit).getDocuments { snapShot, error in
            if let error = error {
                completion(error)
            }
            
            guard let snapShot = snapShot else { return }
            
            self.fetchQuotesFromSnapShotSaveToCoreData(snapShot.documents)
            completion(nil)
//            let quotes = self.fetchQuotesFromSnapShot(snapShot.documents)
//            completion(quotes, nil)
            
        }
    }
    
    // MARK: fetchQuotesFromFireStore
    func fetchQuotesFromFireStore(limit: Int = 10, completion: @escaping (Error?) -> ()) {
        quoteQuery.limit(to: limit).getDocuments { snapShot, error in
            if let error = error {
                completion(error)
            }

            guard let snapShot = snapShot else { return }
//            let quotes = self.fetchQuotesFromSnapShot(snapShot.documents)
            // get last query for paging
            self.fetchQuotesFromSnapShotSaveToCoreData(snapShot.documents)
            self.lastQueryDocumentSnapshot = snapShot.documents.last!
            completion(nil)
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
    
    private func fetchQuotesFromSnapShotSaveToCoreData( _ documents: [QueryDocumentSnapshot]) {
        for doc in documents {
            let data = doc.data() as [String: Any]
            let id = data["id"] as! String
            let body = data["body"] as! String
            let author = data["author"] as! String
                
            let _ = Quote(body: body, author: author, id: id, like: false)

            let moc = CoreDataStack.shared.mainContext
            try! moc.save()
        }
    }
}
