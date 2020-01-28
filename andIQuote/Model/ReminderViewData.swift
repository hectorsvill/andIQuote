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
        let defaults = UserDefaults.standard
        
        let reminderValue = defaults.integer(forKey: _dailyReminderKey + "Reminders")
        let startTimeValue = defaults.integer(forKey: _dailyReminderKey + "Start Time")
        let endTimeValue = defaults.integer(forKey: _dailyReminderKey + "End Time")
        let soundValue = defaults.integer(forKey: _dailyReminderKey + "Sound")
        
        _ = [ ReminderViewData(title: "Reminders", value: reminderValue),
              ReminderViewData(title: "Start Time", value: startTimeValue == 0 ? 6 : startTimeValue),
              ReminderViewData(title: "End Time", value: endTimeValue == 0 ? 22 : endTimeValue),
              ReminderViewData(title: "Sound", value: soundValue),
            ].map { reminderViewData.append($0) }
        
        _ = reminderViewData.map { reminderNotificationData[$0.title] = $0.value }
    }
}
