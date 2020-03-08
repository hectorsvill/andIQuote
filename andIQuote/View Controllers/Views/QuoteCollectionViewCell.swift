//
//  QuoteViewCell.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

protocol QuoteCollectionViewCellDelegate: AnyObject {
    func bookmarkButtonPressed()
    func shareButtonPressed(_ view: UIView)
}

class QuoteCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier = "QuoteCell"
    var delegate: QuoteCollectionViewCellDelegate?
    var quoteController: QuoteController?
    var quote: Quote? { didSet { setupView()} }
    
    var quoteTextView: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.textAlignment = .justified
        textview.backgroundColor = .clear
        textview.isEditable = false
        textview.isSelectable = false
        textview.isScrollEnabled = false
        return textview
    }()


    var bookmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let symbolicConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let image = UIImage(systemName: "bookmark", withConfiguration: symbolicConfig)
        button.setImage(image, for: .normal)
        return button
    }()

    var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let symbolicConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: symbolicConfig)
        button.setImage(image, for: .normal)
        return button
    }()

    private func setupView() {
        layer.borderWidth = 0.25
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 12
        backgroundColor = .clear

        guard let quote = quote, let quoteController = quoteController else { return }
        quoteTextView.attributedText = quoteController.attributedString(quote)

//        quoteTextView.layer.borderWidth = 0.24
//        quoteTextView.layer.borderColor = UIColor.black.cgColor

        bookmarkButton.tintColor = .black
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonPressed), for: .touchUpInside)
        shareButton.tintColor = .black
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)

        [shareButton,quoteTextView, bookmarkButton]
            .forEach { addSubview($0) }


        let inset: CGFloat = 8

        NSLayoutConstraint.activate([
            quoteTextView.centerYAnchor.constraint(equalTo: centerYAnchor),
            quoteTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            quoteTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            quoteTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),

            bookmarkButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -inset),
            bookmarkButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -inset),

            shareButton.rightAnchor.constraint(equalTo: bookmarkButton.safeAreaLayoutGuide.leftAnchor, constant: -inset*2),
            shareButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -inset),


        ])
    }

    @objc func bookmarkButtonPressed() {
        delegate?.bookmarkButtonPressed()
    }

    @objc func shareButtonPressed() {
        shareButton.isHidden = true
        bookmarkButton.isHidden = true
        delegate?.shareButtonPressed(self)
        shareButton.isHidden = false
        bookmarkButton.isHidden = false
    }
}
