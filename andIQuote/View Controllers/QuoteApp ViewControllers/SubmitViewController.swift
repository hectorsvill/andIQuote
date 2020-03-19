//
//  SubmitViewController.swift
//  andIQuote
//
//  Created by s on 3/17/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class SubmitViewController: UIViewController {
    enum Section{ case main }
    var authors: [String] = []
    var quoteController: QuoteController!
    var quoteMaxLength = 130
    var tableView: UITableView! = nil
    var dataSource: UITableViewDiffableDataSource<Section, String>! = nil
    let cellId = "SubmitViewControllerCell"

    var submitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        let attributes_a = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 34),
            NSAttributedString.Key.foregroundColor: UIColor.label,
            ]

        let attributes_b = [
        NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 24),
        NSAttributedString.Key.foregroundColor: UIColor.label,
        ]

        let attributedString = NSMutableAttributedString(string: "Submit ", attributes: attributes_a)
        attributedString.append(NSMutableAttributedString(string: "a quote!", attributes: attributes_b))
//        attributedString.append(NSMutableAttributedString(string: "\nquote: ", attributes: attributes_b))

        label.attributedText = attributedString
        label.numberOfLines = 0
        return label
    }()

    var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.label.cgColor
        textView.layer.borderWidth = 0.4
        textView.layer.cornerRadius = 4.5
        textView.font = .systemFont(ofSize: 16)
        return textView
    }()

    var bodyTextCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()

    var submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("submit quote", for: .normal)
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 0.4
        return button
    }()

    var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.textColor = .label
        label.text = "author:"
        label.textAlignment = .center
        return label
    }()

    var authorTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16)
        textField.layer.cornerRadius = 4.5
        textField.layer.borderWidth = 0.4
        textField.layer.borderColor = UIColor.label.cgColor
        textField.textAlignment = .center

        return textField
    }()

}

extension SubmitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        authors = quoteController.authors
        view.backgroundColor = .systemBackground
        title  = "Submit"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .done, target: self, action: #selector(submitQuote))
        navigationItem.rightBarButtonItem?.tintColor = .label
        setupTableView()
        setupViews()
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 50
        tableView.delegate = self
        view.addSubview(tableView)

        dataSource = UITableViewDiffableDataSource<Section, String>(tableView: tableView) { tableView, indexPath, author -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath)
            let text = indexPath.row  == 0 ? "Anonymous" : author
            cell.textLabel?.text = text
            cell.textLabel?.textColor = .label
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .disclosureIndicator
            return cell
        }

        reLoadData(authors)
    }

    private func setupViews() {
        bodyTextCountLabel.text = "0/\(quoteMaxLength)"
        bodyTextView.delegate = self
        authorTextField.delegate = self

        [submitLabel, bodyTextView, bodyTextCountLabel, authorLabel, authorTextField].forEach{view.addSubview($0)}

        let inset: CGFloat = 8

        NSLayoutConstraint.activate([
            submitLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            submitLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset),
            submitLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -inset),
            submitLabel.bottomAnchor.constraint(equalTo: bodyTextView.safeAreaLayoutGuide.topAnchor, constant: -inset),

            bodyTextView.topAnchor.constraint(equalTo: submitLabel.safeAreaLayoutGuide.bottomAnchor, constant: inset),
            bodyTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset),
            bodyTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -inset),
            bodyTextView.heightAnchor.constraint(equalToConstant: 140),

            bodyTextCountLabel.topAnchor.constraint(equalTo: bodyTextView.safeAreaLayoutGuide.bottomAnchor, constant: inset),
            bodyTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset),
            bodyTextCountLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -inset),

            authorLabel.topAnchor.constraint(equalTo: bodyTextView.safeAreaLayoutGuide.bottomAnchor, constant: inset),
            authorLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset),
            authorLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -inset),

            authorTextField.topAnchor.constraint(equalTo: authorLabel.safeAreaLayoutGuide.bottomAnchor, constant: inset),
            authorTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset),
            authorTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -inset),
            authorTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 40),

            tableView.topAnchor.constraint(equalTo: authorTextField.safeAreaLayoutGuide.bottomAnchor, constant: inset),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -inset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset)

        ])
    }

    func reLoadData(_ data: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    @objc func submitQuote() {
        guard let body = bodyTextView.text, let author = authorTextField.text else { return }
        let quote = Quote(body: body, author: author, id: "", like: false)
        var message = ""

        // mark perfrom check here
        if body.count > 300 {
            message = "Please use \(quoteMaxLength) characters max!"
        }else if body.count < 5 {
            message = "Your quote is short!"
        } else if body.isEmpty && author.isEmpty {
            message = "Quote/Author is empty!"
        } else {
            message = "Thank You for your submission!"
            quoteController.firestore.sendQuoteForSubmit(quote)
        }

        let alertController = UIAlertController(title: "andIQuote", message: message, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "OK", style: .default) {  _ in
            self.navigationController?.dismiss(animated: true, completion: nil)
        })

        present(alertController, animated: true)
    }
}

extension SubmitViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let text = bodyTextView.text!
        bodyTextCountLabel.text = "\(text.count)/\(quoteMaxLength)"
    }

}

extension SubmitViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text!
        let filter_authors = authors.filter{ $0.lowercased().contains(text.lowercased()) }
        reLoadData(filter_authors == [] ? authors : filter_authors)
        return true
    }
}

extension SubmitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        authorTextField.text = authors[indexPath.row]
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        authorTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
    }

}
