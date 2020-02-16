//
//  QuoteViewCell.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

class QuoteCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier = "QuoteCell"

    var quoteController: QuoteController?
    var quote: Quote? { didSet { setupView()} }
    
    let quoteTextView: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.textAlignment = .justified
        textview.backgroundColor = .clear
        textview.isEditable = false
        textview.isSelectable = false
        textview.isScrollEnabled = false
        return textview
    }()

    private func setupView() {
        guard let quote = quote, let quoteController = quoteController else { return }
        quoteTextView.attributedText = quoteController.attributedString(quote)
        addSubview(quoteTextView)
        NSLayoutConstraint.activate([
            quoteTextView.centerYAnchor.constraint(equalTo: centerYAnchor),
            quoteTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            quoteTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            quoteTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
}
