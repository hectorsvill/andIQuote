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
    var value: Int
    
    init (title: String, value: Int) {
        self.title = title
        self.value = value
    }
}

extension DailyReminderViewController {
    func createReminderViewlData() {
        
        _ = [ ReminderViewData(title: "Reminders", value: 0),
              ReminderViewData(title: "Start Time", value: 6),
              ReminderViewData(title: "End Time", value: 22),
              ReminderViewData(title: "Sound", value: 1),
            ].map { reminderViewData.append($0) }
        
        if let dict = UserDefaults().dictionary(forKey: _dailyReminderKey) {
            reminderNotificationData = dict as! [String: Int]
        } else {
            _ = reminderViewData.map {
                reminderNotificationData[$0.title] = $0.value
            }
        }
    }
}
