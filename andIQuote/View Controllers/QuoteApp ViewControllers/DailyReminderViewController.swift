//
//  DailyReminderViewController.swift
//  andIQuote
//
//  Created by s on 1/25/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import EventKit
import UIKit

class DailyReminderViewController: UIViewController {
    var reminderCellData = [ReminderCell]()
    var quoteController: QuoteController!
    var tableView: UITableView!
    
    var finishButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Finish", for: .normal)
        button.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.text = "SETTING DAILY REMINDERS WILL HElP YOU STAY MINDFUL SO YOU MAY REMAIN CONSCIOUS AND AWARE."
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        createReminderCellData()
        setupLayouts()
    }
    
    
    func setupLayouts() {
        titleLabel.text = "Daily Reminders"
        let mainStackView = UIStackView(arrangedSubviews: [finishButton, titleLabel, descriptionLabel])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .top
        mainStackView.spacing = 8

        view.addSubview(mainStackView)
        
        
        let r1 = DailyReminderView()
        r1.reminderCell = reminderCellData[0]
        r1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        r1.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        mainStackView.addArrangedSubview(r1)
    
        NSLayoutConstraint.activate([
            finishButton.widthAnchor.constraint(equalToConstant: 60),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            mainStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            mainStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
        ])
    }
    
    @objc func finishButtonPressed() {
        dismiss(animated: true)
    }
}

extension DailyReminderViewController: ReminderCellButtonPressedDelegate {
    func plusminusbuttonPressed(reminderCell: ReminderCell, tag: Int) {
        print(tag)
    }
    
    
}
