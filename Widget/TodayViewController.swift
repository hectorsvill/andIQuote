//
//  TodayViewController.swift
//  Widget
//
//  Created by s on 4/12/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import CoreData
import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

    var quotes = [Quote]()

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Quote")

        let storeDescriptore = NSPersistentStoreDescription(url: URL.storeURL(dataBaseName: "Quote"))
        container.persistentStoreDescriptions = [storeDescriptore]

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("here")

        fetchQuotesFromCoreData { quotes, error in
            if let error = error {

                NSLog("error fetching from core Data: %@", error.localizedDescription)
            }

            guard let quotes = quotes else { return }

            self.quotes = quotes.shuffled()
            print(quotes.count)
        }
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }


    func fetchQuotesFromCoreData(completion: @escaping ([Quote]?, Error?) -> ()){
        
        container.viewContext.performAndWait {
            let quoteFetch: NSFetchRequest<Quote> = Quote.fetchRequest()
            quoteFetch.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]

            do {
                _ = try container.viewContext.fetch(quoteFetch)
                let quotes = try quoteFetch.execute()
                completion(quotes, nil)
            }catch {
                completion(nil, error)
            }
        }
    }
}
