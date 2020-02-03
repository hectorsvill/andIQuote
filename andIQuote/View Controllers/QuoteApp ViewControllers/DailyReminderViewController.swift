//
//  DailyReminderViewController.swift
//  andIQuote
//
//  Created by s on 1/25/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import EventKit
import UIKit

final class DailyReminderViewController: UIViewController {
    var reminderViewData = [ReminderViewData]()
    var quoteController: QuoteController!
    var reminderNotificationData: [String: Int] = [:]
    let userNotificationCenter = UNUserNotificationCenter.current()
    let _dailyReminderKey = "DailyReminderViewController.reminderNotificationData"
    // MARK : finishButton
    var finishButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Finish", for: .normal)
        button.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
        return button
    }()
    // MARK: titleLabel
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    // MARK: descriptionLabel
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.text = "SETTING DAILY REMINDERS WILL HElP YOU STAY MINDFUL SO YOU MAY REMAIN CONSCIOUS AND AWARE."
        return label
    }()
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        createReminderViewlData()
        setupLayouts()
        requestNotificationAuthorization()
        view.setBackground(to: quoteController.background)
    }
    // MARK:viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if reminderNotificationData[reminderViewData[0].title]! > 0 {
            userNotificationCenter.getPendingNotificationRequests { n in
                print(n.count)
                if n.count == 0 {
                    self.setupsendNotification()
                }
            }
        } else {
            removeAllNotifications()
        }
    }
    // MARK: removeAllNotifications
    private func removeAllNotifications() {
        userNotificationCenter.removeAllDeliveredNotifications()
        userNotificationCenter.removeAllPendingNotificationRequests()
    }
    // MARK: requestNotificationAuthorization
    private func requestNotificationAuthorization() {
        let options = UNAuthorizationOptions.init(arrayLiteral: .alert, .sound)
        userNotificationCenter.requestAuthorization(options: options) { bool, error in
            if let error = error {
                NSLog("\(error)")
            }
        }
    }
    // MARK: sendNotification
    private func setupsendNotification() {
        quoteController.fetchQuotesFromCoreData { quotes, error in
            if let error = error {
                NSLog("\(error)")
            }
            
            guard let quotes = quotes else { return }
            let count = self.reminderNotificationData["Reminders"]!
            let startTime = self.reminderNotificationData["Start Time"]!
            //let endTime = self.reminderNotificationData["End Time"]!
            for i in 0..<count {
                if let randomQuote = quotes.randomElement() {
                    self.createNotification(startTime + i, quote: randomQuote)
                }
            }
        }
     }
    // MARK: createNotification
    private func createNotification(_ hour: Int, quote: Quote) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = quote.author!
        notificationContent.body = quote.body!
        
        if self.reminderNotificationData["Sound"]! == 1 {
            notificationContent.sound = .default
        }
        
        switch self.reminderNotificationData["Sound"]! {
        case 1:
            notificationContent.sound = .defaultCriticalSound(withAudioVolume: 0.2)
        case 2:
            notificationContent.sound = .defaultCriticalSound(withAudioVolume: 0.4)
        case 3:
            notificationContent.sound = .defaultCriticalSound(withAudioVolume: 0.6)
        case 4:
            notificationContent.sound = .defaultCriticalSound(withAudioVolume: 0.8)
        case 5:
            notificationContent.sound = .defaultCriticalSound(withAudioVolume: 1.0)
        default:
            notificationContent.sound = .none
        }
        
        notificationContent.title = quote.author!
        notificationContent.body = quote.body!
        
        var dateComponent = DateComponents()
        dateComponent.hour = hour
        dateComponent.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        let request = UNNotificationRequest(identifier: quote.id!, content: notificationContent, trigger: trigger)
        
        self.userNotificationCenter.add(request) { error in
            if let error = error {
                NSLog("\(error)")
            }
        }
    }
    
    // MARK: createSplitView
    private func createSplitView() -> UIView{
        let splitView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 2))
        splitView.backgroundColor = .label
        splitView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        splitView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        splitView.layer.cornerRadius = 5
        return splitView
    }
    // MARK: createReminderView
    private func createReminderView(_ reminderCellData: ReminderViewData) -> UIView {
        let dailyReminderView = DailyReminderView()
        dailyReminderView.deleagate = self
        dailyReminderView.reminderViewData = reminderCellData
        dailyReminderView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        dailyReminderView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        return dailyReminderView
    }
    // MARK: setupLayouts
    func setupLayouts() {
        titleLabel.text = "Daily Reminders"
        
        let splitView1 = createSplitView()
        let splitView2 = createSplitView()
        
        let remindersView = createReminderView(reminderViewData[0])
        let startView = createReminderView(reminderViewData[1])
//        let stopView = createReminderView(reminderViewData[2])
        let typeView = createReminderView(reminderViewData[3])
        let views = [finishButton, titleLabel, descriptionLabel, remindersView, splitView1, startView, splitView2, typeView]
        
        let mainStackView = UIStackView(arrangedSubviews: views)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .top
        mainStackView.spacing = 8
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            finishButton.widthAnchor.constraint(equalToConstant: 60),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            mainStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            mainStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
        ])
    }
    // MARK: finishButtonPressed
    @objc func finishButtonPressed() {
        dismiss(animated: true)
    }
}
// MARK: ReminderCellButtonPressedDelegate
extension DailyReminderViewController: ReminderCellButtonPressedDelegate {
    private func impactGesture(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactFeedback = UIImpactFeedbackGenerator(style: style)
        impactFeedback.impactOccurred()
    }
    
    func plusminusbuttonPressed(reminderViewData: ReminderViewData, tag: Int) {
        reminderNotificationData[reminderViewData.title] = reminderViewData.value
        UserDefaults.standard.set(reminderNotificationData[reminderViewData.title], forKey: _dailyReminderKey + reminderViewData.title)
        impactGesture(style: .rigid)
    }
}
