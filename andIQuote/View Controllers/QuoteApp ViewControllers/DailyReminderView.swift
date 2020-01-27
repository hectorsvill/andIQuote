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
    var reminderViewData = [ReminderViewData]()
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
    
    private func createSplitView() -> UIView{
        let splitView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 10))
        splitView.backgroundColor = .systemGray4
        splitView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        splitView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        splitView.layer.cornerRadius = 5
        return splitView
    }
    
    private func createReminderView(_ reminderCellData: ReminderViewData) -> UIView {
        let dailyReminderView = DailyReminderView()
        dailyReminderView.deleagate = self
        dailyReminderView.reminderCell = reminderCellData
        dailyReminderView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        dailyReminderView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        return dailyReminderView
    }
    
    func setupLayouts() {
        titleLabel.text = "Daily Reminders"
        
        let splitView1 = createSplitView()
        let splitView2 = createSplitView()
        
        let remindersView = createReminderView(reminderViewData[0])
        let startView = createReminderView(reminderViewData[1])
        let stopView = createReminderView(reminderViewData[2])
        let typeView = createReminderView(reminderViewData[3])
        let views = [finishButton, titleLabel, descriptionLabel, remindersView, splitView1, startView, stopView, splitView2, typeView]
        
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
    
    @objc func finishButtonPressed() {
        dismiss(animated: true)
    }
}

extension DailyReminderViewController: ReminderCellButtonPressedDelegate {
    func plusminusbuttonPressed(reminderCell: ReminderViewData, tag: Int) {
        print(tag)
    }
    
    
}
