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
        
        let splitView1 = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 10))
        splitView1.backgroundColor = .systemGray4
        splitView1.heightAnchor.constraint(equalToConstant: 10).isActive = true
        splitView1.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        splitView1.layer.cornerRadius = 5
        
        let splitView2 = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 10))
        splitView2.backgroundColor = .systemGray4
        splitView2.heightAnchor.constraint(equalToConstant: 10).isActive = true
        splitView2.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        splitView2.layer.cornerRadius = 5
        
        let remindersView = DailyReminderView()
        remindersView.deleagate = self
        remindersView.reminderCell = reminderCellData[0]
        remindersView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        remindersView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true

        let startView = DailyReminderView()
        startView.deleagate = self
        startView.reminderCell = reminderCellData[1]
        startView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        startView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        
        let stopView = DailyReminderView()
        stopView.deleagate = self
        stopView.reminderCell = reminderCellData[2]
        stopView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        stopView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        
        let typeView = DailyReminderView()
        typeView.deleagate = self
        typeView.reminderCell = reminderCellData[3]
        typeView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        typeView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        
        let mainStackView = UIStackView(arrangedSubviews: [finishButton, titleLabel, descriptionLabel, remindersView, splitView1, startView, stopView, splitView2, typeView])
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
    
    @objc func finishButtonPressed() {
        dismiss(animated: true)
    }
}

extension DailyReminderViewController: ReminderCellButtonPressedDelegate {
    func plusminusbuttonPressed(reminderCell: ReminderCell, tag: Int) {
        print(tag)
    }
    
    
}
