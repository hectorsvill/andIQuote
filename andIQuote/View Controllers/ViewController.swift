//
//  ViewController.swift
//  andIQuote
//
//  Created by Hector on 12/16/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    let myStrKey = "https://wisdomquotes.com/history-quotes/"
    let url = URL(string: "https://wisdomquotes.com/history-quotes/")!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let historystr = UserDefaults.standard.string(forKey: myStrKey) {
            print(historystr)
            
        } else {
            
            let data = try! Data(contentsOf: url)
            let str = String(data: data, encoding: .utf8)!
            UserDefaults.standard.set(str, forKey: myStrKey)
        }

        
    }
 
}
