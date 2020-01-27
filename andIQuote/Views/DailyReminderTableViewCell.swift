//
//  DailyReminderTableViewCell.swift
//  andIQuote
//
//  Created by s on 1/26/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit


class DailyReminderView: UIView {
    var stackView: UIStackView!
    var deleagate: ReminderCellButtonPressedDelegate?
    
    var reminderCell: ReminderCell? {
        didSet { setupViews() }
    }

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    var steperDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    var minusButton: UIButton = {
        let button = UIButton().sfImageButton(systemName: "minus.square")
        button.tintColor = .label
        button.tag = 1
        return button
    }()
    
    var plussButton: UIButton = {
        let button = UIButton().sfImageButton(systemName: "plus.square")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.tag = 2
        return button
    }()
    
    private func setupViews() {
        backgroundColor = .systemGray6
        guard let reminderCell = reminderCell else { return }
        
        descriptionLabel.text = reminderCell.title
        steperDescriptionLabel.text = reminderCell.steperDescription
        steperDescriptionLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        stackView = UIStackView(arrangedSubviews: [descriptionLabel, minusButton,steperDescriptionLabel, plussButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
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
    
    @objc func plusminusbuttonPressed(_ sender: UIButton) {
        guard let reminderCell = reminderCell else { return }
        deleagate?.plusminusbuttonPressed(reminderCell: reminderCell, tag: sender.tag)
        
        if sender.tag == 1 {
            if descriptionLabel.text == "Reminders" {
                if reminderCell.value >= 1 {
                    reminderCell.value -= 1
                    steperDescriptionLabel.text = "\(reminderCell.value)X"
                }
            } else if descriptionLabel.text == "Start Time" || descriptionLabel.text == "End Time" {
                if reminderCell.value >= 1 {
                    reminderCell.value -= 1
                    steperDescriptionLabel.text = "\(reminderCell.value):00"
                }

            } else if descriptionLabel.text ==  "End Time" {

            }
        } else {
            if descriptionLabel.text == "Reminders" {
                if reminderCell.value <= 4 {
                    reminderCell.value += 1
                    steperDescriptionLabel.text = "\(reminderCell.value)X"
                }
            } else if descriptionLabel.text == "Start Time" || descriptionLabel.text == "End Time" {
                if reminderCell.value <= 23 {
                    reminderCell.value += 1
                    steperDescriptionLabel.text = "\(reminderCell.value):00"
                }
            }
        }
    }
}


// MARK: CLEAN THIS !!!!!!!!!!!!

protocol ReminderCellButtonPressedDelegate {
    func plusminusbuttonPressed(reminderCell: ReminderCell, tag: Int)
}

extension DailyReminderViewController {
    func createReminderCellData() {
        _ = [ ReminderCell(title: "Reminders",  steperDescription: "0X", value: 0),
              ReminderCell(title: "Start Time", steperDescription: "6:00", value: 6),
              ReminderCell(title: "End Time",   steperDescription: "22:00", value: 22),
              ReminderCell(title: "Sound",   steperDescription: "1", value: 1),
            ].map { reminderCellData.append($0) }
    }
}

class ReminderCell {
    let title: String
    var steperDescription: String
    var value: Int
    
    init (title: String, steperDescription: String,value: Int) {
        self.title = title
        self.value = value
        self.steperDescription = steperDescription
    }
}
