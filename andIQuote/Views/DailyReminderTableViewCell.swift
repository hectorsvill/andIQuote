//
//  DailyReminderTableViewCell.swift
//  andIQuote
//
//  Created by s on 1/26/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class DailyReminderTableViewCell: UITableViewCell {
    
    var reminderCell: ReminderCell? {
        didSet { setupViews() }
    }

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    var steperDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    var plussButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let plussIMage = UIImage(systemName: "plus.square", withConfiguration: UIImage().mainViewSymbolConfig())
        button.setImage(plussIMage, for: .normal)
        button.tintColor = .label
//        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return button
    }()
    
    var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let plussIMage = UIImage(systemName: "minus.square", withConfiguration: UIImage().mainViewSymbolConfig())
        button.setImage(plussIMage, for: .normal)
        button.tintColor = .label
//        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return button
    
    }()
    
    private func setupViews() {
        backgroundColor = .systemGray6
        
        guard let reminderCell = reminderCell else { return }
        descriptionLabel.text = reminderCell.title
        steperDescriptionLabel.text = reminderCell.steperDescription
        let stackViiew = UIStackView(arrangedSubviews: [descriptionLabel, plussButton,steperDescriptionLabel, minusButton])
        stackViiew.translatesAutoresizingMaskIntoConstraints = false
        stackViiew.axis = .horizontal
        stackViiew.spacing = 8
        addSubview(stackViiew)
        
        NSLayoutConstraint.activate([
            stackViiew.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackViiew.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackViiew.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            stackViiew.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
        
    }
}

extension DailyReminderViewController {
    func createReminderCellData() {
        _ = [ ReminderCell(title: "Reminders",  steperDescription: "1X"),
              ReminderCell(title: "Start Time", steperDescription: "06:00"),
              ReminderCell(title: "End Time",   steperDescription: "10:00"),
            ].map { reminderCellData.append($0) }
    }
}

struct ReminderCell {
    let title: String
    let steperDescription: String
    let value = 0
}
