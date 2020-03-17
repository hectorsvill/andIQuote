//
//  SubmitViewController.swift
//  andIQuote
//
//  Created by s on 3/17/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class SubmitViewController: UIViewController {


    var submitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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

        label.attributedText = attributedString
        return label
    }()

    var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.label.cgColor
        textView.layer.borderWidth = 0.4
        textView.layer.cornerRadius = 5
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title  = "Submit"

        setupViews()
    }


    private func setupViews() {

        bodyTextView.delegate = self
        [submitLabel, bodyTextView,].forEach{view.addSubview($0)}

        let inset: CGFloat = 8

        NSLayoutConstraint.activate([
            submitLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            submitLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset),
            submitLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -inset),
            submitLabel.bottomAnchor.constraint(equalTo: bodyTextView.safeAreaLayoutGuide.topAnchor, constant: -inset),

//            bodyTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
//            bodyTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: inset),
//            bodyTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -inset),
//            bodyTextView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
}



extension SubmitViewController: UITextViewDelegate {


    func textViewDidEndEditing(_ textView: UITextView) {

        let text = textView.text!

        print(text)
    }




}
