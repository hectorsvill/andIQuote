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

        setBackground(to: quoteController.background)

        let borderWidth: CGFloat = 0.25
        let cornerRadius: CGFloat = 18

        layer.cornerRadius = cornerRadius
        contentView.layer.cornerRadius = cornerRadius

        setupSwipeGestureRecognizer()

        if quoteController.background == "systemBackground" {
            layer.borderWidth = borderWidth
            layer.borderColor = UIColor.systemGray.cgColor
            contentView.layer.borderWidth = borderWidth
            contentView.layer.borderColor = UIColor.systemGray.cgColor
        }

        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonPressed), for: .touchUpInside)

        let tintColor = quoteController.quoteForegroundColor//quoteController.background == quoteController.backgrounds[0] ? .label : UIColor.white
        bookmarkButton.tintColor = tintColor
        shareButton.tintColor = tintColor
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)

        [shareButton, quoteTextView, bookmarkButton].forEach { addSubview($0) }

        let inset: CGFloat = 8

        NSLayoutConstraint.activate([
            quoteTextView.centerYAnchor.constraint(equalTo: centerYAnchor),
            quoteTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            quoteTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            quoteTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),

            bookmarkButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -inset*2),
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
        bookmarkButton.accessibilityIdentifier = imageName
        bookmarkButton.setImage(image, for: .normal)
        isBookmark.toggle()
        quote.like.toggle()
        
        do { try CoreDataStack.shared.mainContext.save() } catch {
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

// MARK: - GestureRecognizer
extension QuoteCollectionViewCell {
    func setupSwipeGestureRecognizer() {
        let upSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(shareButtonPressed))
        upSwipeGestureRecognizer.direction = .up
        addGestureRecognizer(upSwipeGestureRecognizer)

        let doubleTapSwipeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bookmarkButtonPressed))
        doubleTapSwipeGestureRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapSwipeGestureRecognizer)
    }
}
