//
//  ReminderViewData.swift
//  andIQuote
//
//  Created by s on 1/27/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation

class ReminderViewData {
    let title: String
    var steperDescription: String
    var value: Int
    
    init (title: String, steperDescription: String,value: Int) {
        self.title = title
        self.value = value
        self.steperDescription = steperDescription
    }
}
