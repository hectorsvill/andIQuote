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
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }


    func fetchQuotes() {
        
    }
    
}
