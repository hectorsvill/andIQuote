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
    @IBOutlet weak var quoteLabel: UILabel!

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
        setupViews()
    }

    func setupViews() {
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        preferredContentSize = CGSize(width: 0, height: 400)

        fetchQuotesFromCoreData { [unowned self] quotes, error in
            if let error = error {

                NSLog("error fetching from core Data: %@", error.localizedDescription)
            }

            guard let quotes = quotes else { return }
            self.quotes = quotes.shuffled()

            DispatchQueue.main.async {
                self.quoteLabel.attributedText = NSMutableAttributedString.attributedString(quotes[0], font: 16, quoteForegroundColor: UIColor.label)
            }
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

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .expanded:
            preferredContentSize = CGSize(width: 0, height: 550)
        case .compact:
            preferredContentSize = CGSize(width: 0, height: 400)
        @unknown default:
            fatalError()
        }
    }
}
