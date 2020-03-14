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
    enum Section{ case main }
    var dataSource: UITableViewDiffableDataSource<Section, String>! = nil
    var delegate: SearchViewControllerDelegate?
    var searchData: [String] = []
    var tableView: UITableView! = nil
    var searchbar: UISearchBar! = nil
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(exitView))
        navigationItem.leftBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem?.tintColor = .label

        createViews()
        configureDatasource()
    }

    @objc func exitView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    private func createViews() {
        //  searchBar
        searchbar = UISearchBar()
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        searchbar.sizeToFit()
        searchbar.placeholder = "Search by Autho"
        searchbar.barTintColor = .label
        searchbar.delegate = self
        navigationItem.titleView = searchbar
        // tableView
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.rowHeight = 70

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

    private func configureDatasource() {
        dataSource = UITableViewDiffableDataSource<Section, String>(tableView: tableView, cellProvider: { tableView, indexPath, str -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let text = indexPath.row  == 0 ? "Anonymous" : str
            cell.textLabel?.text = text
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
            cell.textLabel?.textAlignment = .center
            return cell
        })

        reloadData(searchData)
    }

    private func reloadData(_ data: [String]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, String>()
        snapShot.appendSections([.main])
        snapShot.appendItems(data)
        dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.loadSearchData(searchData[indexPath.row])
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchBar.text!
        let data = searchData.filter { $0.contains(text) }
        data == [] ? reloadData(searchData) : reloadData(data)
    }
}
