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

extension DailyReminderViewController {
    func createReminderViewlData() {
        _ = [ ReminderViewData(title: "Reminders",  steperDescription: "0X", value: 0),
              ReminderViewData(title: "Start Time", steperDescription: "6:00", value: 6),
              ReminderViewData(title: "End Time",   steperDescription: "22:00", value: 22),
              ReminderViewData(title: "Sound",   steperDescription: "1", value: 1),
            ].map { reminderViewData.append($0) }
        
        _ = reminderViewData.map {
            reminderNotificationData[$0.title] = $0.value
        }
    }
}
