//
//  SearchViewController.swift
//  andIQuote
//
//  Created by s on 3/10/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    var searchData: [String] = []
    var tableView: UITableView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search by Author"
        view.backgroundColor = .systemBackground
        createTableView()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(exitView))
        navigationItem.leftBarButtonItem?.tintColor = .label
    }

    @objc func exitView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}


extension SearchViewController: UITableViewDataSource {

    private func createTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.rowHeight = 70
//        tableView.delegate = self
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = searchData[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
        cell.textLabel?.textAlignment = .center
        return cell
    }




}
