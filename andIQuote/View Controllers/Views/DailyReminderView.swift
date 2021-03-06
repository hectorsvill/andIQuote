//
//  DailyReminderView.swift
//  andIQuote
//
//  Created by s on 1/26/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class DailyReminderView: UIView {
    var deleagate: ReminderCellButtonPressedDelegate?
    var config: Int! { didSet { setupViews() } }
    var value = 0
    let _dailyReminderKey = "DailyReminderViewController.reminderNotificationData"
    var stackView: UIStackView! = nil
    // MARK: descriptionLabel
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    // MARK: steperDescriptionLabel
    var steperDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        return label
    }()
    // MARK: minusButton
    var minusButton: UIButton = {
        let button = UIButton().sfImageButton(systemName: "minus.square")
        button.tintColor = .label
        button.tag = 0
        return button
    }()
    // MARK: plussButton
    var plussButton: UIButton = {
        let button = UIButton().sfImageButton(systemName: "plus.square")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.tag = 1
        return button
    }()
    // MARK: timePicker
    var timePicker: UIDatePicker = {
        let timepicker = UIDatePicker()
        timepicker.translatesAutoresizingMaskIntoConstraints = false
        timepicker.datePickerMode = .time
        timepicker.layer.cornerRadius = 4
        timepicker.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)
        timepicker.isAccessibilityElement = true
        return timepicker
    }()
    // MARK: setupViews
    private func setupViews() {
        setupDescriptionLabel()
        setupSteperDescriptionText()

        stackView = UIStackView(arrangedSubviews: [descriptionLabel])
        
        configureAccessibilityID()
        
        if config == 1 {
            stackView.addArrangedSubview(timePicker)
        } else {
            stackView.addArrangedSubview(minusButton)
            stackView.addArrangedSubview(steperDescriptionLabel)
            stackView.addArrangedSubview(plussButton)
        }

        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        
        minusButton.addTarget(self, action: #selector(plusminusbuttonPressed(_:)), for: .touchUpInside)
        plussButton.addTarget(self, action: #selector(plusminusbuttonPressed(_:)), for: .touchUpInside)
        
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            timePicker.widthAnchor.constraint(equalToConstant: 175),
            steperDescriptionLabel.widthAnchor.constraint(equalToConstant: 80),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),
        ])
    }
    
    private func configureAccessibilityID() {
        var descriptionLabelText = descriptionLabel.text!
        let _ = descriptionLabelText.popLast()
        let dailyReminderString = "DailyReminderView\(descriptionLabelText)Stack"
        stackView.accessibilityIdentifier = dailyReminderString
        minusButton.accessibilityIdentifier = "MinusButton"
        plussButton.accessibilityIdentifier = "PlussButton"
        timePicker.accessibilityIdentifier = "TimePicker"
    }
    
    // MARK: setupDescriptionLabel
    private func setupDescriptionLabel() {
        guard let config = config else { return }
        var descriptionText = ""

        switch config {
        case 0:
            descriptionText = "Reminders:"
        case 1:
            descriptionText = "Time:"
        case 2:
            descriptionText = "End Time:"
        case 3:
            descriptionText = "Sound:"
        default:
            fatalError("setupDescriptionLabel - out of range")
        }

        descriptionLabel.text = descriptionText
    }
    // MARK: setupSteperDescriptionText
    private func setupSteperDescriptionText() {
        let key = _dailyReminderKey + descriptionLabel.text!
        value = UserDefaults.standard.integer(forKey: key)

        if config == 1 {
            let date = value == 0 ? Date() : Date(timeIntervalSince1970: Double(value))
            timePicker.date = date
        } else {
            steperDescriptionLabel.text = "\(value)X"
        }
        
    }
    // MARK: plusminusbuttonPressed
    @objc func plusminusbuttonPressed(_ sender: UIButton) {
        let newValue = sender.tag == 0 ? (value - 1) : (value + 1)

        if newValue >= 0 && newValue <= 5 {
            value = newValue
            steperDescriptionLabel.text = "\(value)X"
            deleagate?.plusminusbuttonPressed(config: config!, value: value)
        }
    }
   // MARK: timePickerValueChanged
    @objc func timePickerValueChanged() {
        value = Int(timePicker.date.timeIntervalSince1970)
        deleagate?.plusminusbuttonPressed(config: config, value: value)
    }

}
