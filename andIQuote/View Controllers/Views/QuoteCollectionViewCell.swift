//
//  QuoteViewCell.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

protocol QuoteCollectionViewCellDelegate: AnyObject {
    func bookmarkButtonPressed(_ id: String)
    func shareButtonPressed(_ view: UIView)
}

class QuoteCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier = "QuoteCell"
    var delegate: QuoteCollectionViewCellDelegate?
    var quoteController: QuoteController?
    var quote: Quote? { didSet { setupView()} }
    var isBookmark = false
    
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
        return button
    }()

    var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage().mainViewSymbolConfig())
        button.setImage(image, for: .normal)
        return button
    }()
}

extension QuoteCollectionViewCell {
    private func setupView() {
        guard let quote = quote, let quoteController = quoteController else { return }
        quoteTextView.attributedText = quoteController.attributedString(quote)

        layer.borderWidth = 0.25
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 12
        backgroundColor = .clear

        bookmarkButton.tintColor = .black
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonPressed), for: .touchUpInside)

        shareButton.tintColor = .black
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)

        [shareButton,quoteTextView, bookmarkButton].forEach { addSubview($0) }

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
        guard let quote = quote else { return }
        delegate?.bookmarkButtonPressed(quote.id!)

        let imageName = isBookmark ? "bookmark" : "bookmark.fill"
        let image = UIImage(systemName: imageName, withConfiguration: UIImage().mainViewSymbolConfig())!
        bookmarkButton.setImage(image, for: .normal)
        isBookmark.toggle()
        quote.like.toggle()

        let moc = CoreDataStack.shared.mainContext
        do { try moc.save() } catch {
            NSLog("\(error)")
        }
    }

    @objc func shareButtonPressed() {
        shareButton.isHidden = true
        bookmarkButton.isHidden = true
        delegate?.shareButtonPressed(self)
        shareButton.isHidden = false
        bookmarkButton.isHidden = false
    }
}
