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
        setupLayouts()
    }
    
    
    func setupLayouts() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReminderCell")
        tableView.rowHeight = view.bounds.height / 9
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        view.addSubview(tableView)
        
        titleLabel.text = "Daily Reminders"
        let mainStackView = UIStackView(arrangedSubviews: [finishButton, titleLabel, descriptionLabel])
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
            tableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: (view.frame.height / 5) * -1),
        ])
    }
    
    @objc func finishButtonPressed() {
        dismiss(animated: true)
    }
}

extension DailyReminderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as? DailyReminderTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return " "
        }
        return " "
    }
}


