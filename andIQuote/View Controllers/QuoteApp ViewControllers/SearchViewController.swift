//
//  SearchViewController.swift
//  andIQuote
//
//  Created by s on 3/10/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate {
    func loadSearchData(_ author: String)
}

final class SearchViewController: UIViewController {
    var delegate: SearchViewControllerDelegate?
    var searchData: [String] = []
    var tableView: UITableView! = nil
    var searchbar: UISearchBar! = nil
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search by Author"
        view.backgroundColor = .systemBackground

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(exitView))
        navigationItem.leftBarButtonItem?.tintColor = .label

        createViews()
    }

    @objc func exitView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    private func createViews() {
        //  searchBar
        searchbar = UISearchBar()
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        searchbar.placeholder = "Search"
        searchbar.isTranslucent = false
        searchbar.delegate = self
        // tableView
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        //        tableView.delegate = self

        [searchbar, tableView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            searchbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            searchbar.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor),
            searchbar.leftAnchor.constraint(equalTo: searchbar.safeAreaLayoutGuide.leftAnchor),
            searchbar.rightAnchor.constraint(equalTo: searchbar.safeAreaLayoutGuide.rightAnchor),

            tableView.topAnchor.constraint(equalTo: searchbar.safeAreaLayoutGuide.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let text = searchData[indexPath.row]
        cell.textLabel?.text = text
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
        cell.textLabel?.textAlignment = .center
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.loadSearchData(searchData[indexPath.row])
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
}
