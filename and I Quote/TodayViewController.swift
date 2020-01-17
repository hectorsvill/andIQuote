//
//  TodayViewController.swift
//  and I Quote
//
//  Created by s on 1/16/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Today Viewdidload")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
