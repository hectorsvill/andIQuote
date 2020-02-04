//
//  DailyReminderTableViewCell.swift
//  andIQuote
//
//  Created by s on 1/26/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class DailyReminderView: UIView {
    var deleagate: ReminderCellButtonPressedDelegate?
    var config: Int! { didSet { setupViews() } }
    
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

    var timePicker: UIDatePicker = {
        let timepicker = UIDatePicker()
        timepicker.translatesAutoresizingMaskIntoConstraints = false
        timepicker.datePickerMode = .time
        timepicker.layer.cornerRadius = 4
        return timepicker
    }()

    // MARK: setupViews
    private func setupViews() {
        backgroundColor = .clear

        setupSteperDescriptionText()
        setupDescriptionLabel()
        steperDescriptionLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        timePicker.widthAnchor.constraint(equalToConstant: 175).isActive = true
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel])

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
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
    // MARK: setupDescriptionLabel
    private func setupDescriptionLabel() {
        guard let config = config else { return }
        var descriptionText = ""

        switch config {
        case 0:
            descriptionText = "Reminders"
        case 1:
            descriptionText = "Start Time:"
        case 2:
            descriptionText = "End Time"
        case 3:
            descriptionText = "Sound"
        default:
            fatalError("setupDescriptionLabel - out of range")
        }

        descriptionLabel.text = descriptionText
    }
    // MARK: setupSteperDescriptionText
    private func setupSteperDescriptionText() {
        switch config {
        case 0:
            steperDescriptionLabel.text = "0X"
        case 1:
            print("time picker")
        case 2:
            print("time picker")
        case 3:
            steperDescriptionLabel.text = "0X"
        default:
            fatalError("setupSteperDescriptionText - out of range")
        }
        
    }
    // MARK: plusminusbuttonPressed
    @objc func plusminusbuttonPressed(_ sender: UIButton) {
        print("sender with tag: \(sender.tag)")

        if sender.tag == 0 {


        } else {
        }

        steperDescriptionLabel.text = "\(0)X"
    }
}


