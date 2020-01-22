//
//  Quote+Convenience.swift
//  andIQuote
//
//  Created by s on 1/13/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import CoreData
import Foundation

extension Quote {
    convenience init(body: String, author: String, id: String, like: Bool, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.body = body
        self.author = author
        self.id = id
        self.like = like
    }
}
