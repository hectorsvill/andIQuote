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
    let db = Firestore.firestore()
    
    
    
    var quoteQuery: Query {
        db.collectionGroup("quotes")
    }
    
    func fetchQuotesFromFireStore(completion: @escaping ([QuoteDetail]?, Error?) -> ()) {
        quoteQuery.limit(to: 300).getDocuments { snapShot, error in
            if let error = error {
                completion(nil, error)
            }
            
            guard let snapShot = snapShot else { return }
            let quotes = self.fetchQuotesFromSnapShot(snapShot.documents)
            completion(quotes, nil)
        }
    }
    
    
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
}
