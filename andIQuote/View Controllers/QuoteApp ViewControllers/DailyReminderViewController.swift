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
    var quoteController: QuoteController!
    var userNotificationCenter: UNUserNotificationCenter!
    var remindersView: DailyReminderView!
    var startView: DailyReminderView!
    var soundSelectView: DailyReminderView!
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
        setupLayouts()
        requestNotificationAuthorization()
        view.backgroundColor = .systemBackground
    }
    // MARK:viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        configureNotifications()
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
    private func createReminderView(_ config: Int) -> DailyReminderView {
        let dailyReminderView = DailyReminderView()
        dailyReminderView.deleagate = self
        dailyReminderView.config = config
        dailyReminderView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        dailyReminderView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        return dailyReminderView
    }
    // MARK: setupLayouts
    func setupLayouts() {
        titleLabel.text = "Daily Reminders"
        
        let splitView1 = createSplitView()
        let splitView2 = createSplitView()
        remindersView = createReminderView(0)
        startView = createReminderView(1)
        //let stopView = createReminderView(1)
        soundSelectView = createReminderView(3)

        let views = [finishButton, titleLabel, descriptionLabel, remindersView, splitView1,startView, splitView2, soundSelectView]

        let mainStackView = UIStackView(arrangedSubviews: views as! [UIView])

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .top
        mainStackView.spacing = 8
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            finishButton.widthAnchor.constraint(equalToConstant: 60),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    // MARK: finishButtonPressed
    @objc func finishButtonPressed() {
        dismiss(animated: true)
    }
}
// MARK: ReminderCellButtonPressedDelegate
extension DailyReminderViewController: ReminderCellButtonPressedDelegate {
    func plusminusbuttonPressed(config: Int, value: Int) {
        let userDefaults = UserDefaults.standard
        if config == 0{
            userDefaults.set(value, forKey: _dailyReminderKey + "Reminders:")
        }else if config == 1{
            userDefaults.set(value, forKey: _dailyReminderKey + "Time:")
        } else if config == 3{
            userDefaults.set(value, forKey: _dailyReminderKey + "Sound:")
        }
        impactGesture(style: .rigid)
    }

    private func impactGesture(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactFeedback = UIImpactFeedbackGenerator(style: style)
        impactFeedback.impactOccurred()
    }
}

// MARK: Notifications
extension DailyReminderViewController {
    // MARK: requestNotificationAuthorization
    private func requestNotificationAuthorization() {
        let options = UNAuthorizationOptions.init(arrayLiteral: .alert, .sound)
        userNotificationCenter.requestAuthorization(options: options) { bool, error in
            if let error = error {
                NSLog("\(error)")
            }
        }
    }
    // MARK: configureNotifications
    private func configureNotifications() {
        if remindersView.value == 0 {
            userNotificationCenter.removeAllDeliveredNotifications()
            userNotificationCenter.removeAllPendingNotificationRequests()
        } else if quoteController.remindersCount != remindersView.value || quoteController.remindersStartTime != startView.value {
            userNotificationCenter.removeAllDeliveredNotifications()
            userNotificationCenter.removeAllPendingNotificationRequests()

            guard let random_Quote = quoteController.quotes.randomElement() else {
                // TODO: create uialerts for error
                return
            }

            createNotification(with: random_Quote, badge: NSNumber(integerLiteral: 1))
        }
    }
    // MARK: createNotification
    private func createNotification(with quote: Quote, badge: NSNumber) {
        let startTime = startView.timePicker.date
        let soundValue = soundSelectView.value

        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = quote.author!
        notificationContent.body = quote.body!
        notificationContent.badge = badge

        switch soundValue{
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

        let calendarComponents = Calendar.current.dateComponents([.minute, .hour, .day], from: startTime)
//        let t = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: calendarComponents, repeats: true)
        let request = UNNotificationRequest(identifier: quote.id!, content: notificationContent, trigger: dateTrigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                NSLog("Error: \(error)")
            }
        }
    }
}
