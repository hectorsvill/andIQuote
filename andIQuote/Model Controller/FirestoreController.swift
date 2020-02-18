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
}
extension FirestoreController {
    // MARK: fetchQuotesFromFireStore
    func fetchFirstQuotes(completion: @escaping ([Quote]?, Error?) -> ()) {
        quoteQuery.limit(to: 100).getDocuments { snapShot, error in
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
    // MARK: fetchQuotesFromSnapShotSaveToCoreData
    @discardableResult
    private func fetchQuotesFromSnapShot( _ documents: [QueryDocumentSnapshot]) -> [Quote]{
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
}
