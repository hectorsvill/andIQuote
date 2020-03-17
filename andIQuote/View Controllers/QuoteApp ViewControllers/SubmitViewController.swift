//
//  SubmitViewController.swift
//  andIQuote
//
//  Created by s on 3/17/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class SubmitViewController: UIViewController {
    var  quoteController: QuoteController!

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
        attributedString.append(NSMutableAttributedString(string: "a quote for review!", attributes: attributes_b))
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
        textView.layer.cornerRadius = 8
        textView.font = .systemFont(ofSize: 19)
        return textView
    }()

    var bodyTextCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "0/150"
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title  = "Submit"

        setupViews()
    }


    private func setupViews() {

        bodyTextView.delegate = self
        [submitLabel, bodyTextView, bodyTextCountLabel].forEach{view.addSubview($0)}

        let inset: CGFloat = 8

        NSLayoutConstraint.activate([
            submitLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            submitLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset),
            submitLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -inset),
            submitLabel.bottomAnchor.constraint(equalTo: bodyTextView.safeAreaLayoutGuide.topAnchor, constant: -inset),

            bodyTextView.topAnchor.constraint(equalTo: submitLabel.safeAreaLayoutGuide.bottomAnchor, constant: inset),
            bodyTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset),
            bodyTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -inset),
            bodyTextView.heightAnchor.constraint(equalToConstant: 120),

            bodyTextCountLabel.topAnchor.constraint(equalTo: bodyTextView.safeAreaLayoutGuide.bottomAnchor, constant: inset),
            bodyTextCountLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -inset),
        ])
    }
}



extension SubmitViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        bodyTextCountLabel.text = "\(bodyTextView.text.count)/150"

    }

}
