//
//  DailyReminderViewController.swift
//  andIQuote
//
//  Created by s on 1/25/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class DailyReminderViewController: UIViewController {

    var quoteController: QuoteController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setBackground(to: quoteController.background)
    }
    
    
    
    
}
