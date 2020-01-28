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
    
    var reminderViewData: ReminderViewData? {
        didSet { setupViews() }
    }
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
    // MAKR: setupViews
    private func setupViews() {
        backgroundColor = .systemGray6
        guard let reminderCell = reminderViewData else { return }
        
        descriptionLabel.text = reminderCell.title
        setupSteperDescriptionText()
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
    
    private func setupSteperDescriptionText() {
        guard let reminderViewData = reminderViewData else { return }
        if reminderViewData.title == "Reminders" {
             steperDescriptionLabel.text = "\(reminderViewData.value)X"
        } else if descriptionLabel.text == "Start Time" || descriptionLabel.text == "End Time"  {
             steperDescriptionLabel.text = "\(reminderViewData.value):00"
        }
        
    }
    
    // MARK: plusminusbuttonPressed
    @objc func plusminusbuttonPressed(_ sender: UIButton) {
        guard let reminderViewData = reminderViewData else { return }
        
        if descriptionLabel.text == "Reminders" {
            if reminderViewData.value >= 1 && reminderViewData.value <= 4 || reminderViewData.value == 0 && sender.tag == 1 || reminderViewData.value == 5 && sender.tag == 0{
                reminderViewData.value = sender.tag == 0 ?  reminderViewData.value - 1 : reminderViewData.value + 1
                setupSteperDescriptionText()
                
            }
        } else if descriptionLabel.text == "Start Time" || descriptionLabel.text == "End Time" {
            if reminderViewData.value >= 1 && reminderViewData.value <= 23 ||  reminderViewData.value == 0 && sender.tag == 1 || reminderViewData.value == 24 && sender.tag == 0 {
                reminderViewData.value = sender.tag == 0 ?  reminderViewData.value - 1 : reminderViewData.value + 1
                setupSteperDescriptionText()
            }
            
        }

        deleagate?.plusminusbuttonPressed(reminderViewData: reminderViewData, tag: sender.tag)
    }
}


