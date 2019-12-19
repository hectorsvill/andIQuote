//
//  QuoteViewCell.swift
//  andIQuote
//
//  Created by Hector on 12/13/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit


class QuoteCell: UICollectionViewCell {
    static let reuseId: String = "QuoteCell"
    
    var quote: QuoteDetail? { didSet { setupView()} }

    let quoteTextView: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.textAlignment = .justified
        
        textview.isEditable = false
        textview.isSelectable = false
        textview.isScrollEnabled = false
        return textview
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func getAttributedText() -> NSAttributedString {
        backgroundColor = .systemBackground
        guard let quote = quote else { return NSAttributedString(string: "") }
        let attributedString = NSMutableAttributedString(string: quote.body, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.label])
        let author = quote.author
        attributedString.append(NSAttributedString(string: "\n\n\(author)", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.label]))
        
        return attributedString
    }
    
    private func setupView() {
//        let quoteContainerView = UIView()
//        addSubview(quoteTextView)
//        quoteContainerView.translatesAutoresizingMaskIntoConstraints = false
//        quoteContainerView.backgroundColor =  .blue//.systemBackground
        
        
//        addSubview(quoteContainerView)
        quoteTextView.attributedText = getAttributedText()
        addSubview(quoteTextView)
        NSLayoutConstraint.activate([
            
//            quoteContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            quoteContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            quoteContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            quoteContainerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            
            quoteTextView.centerYAnchor.constraint(equalTo: centerYAnchor),
            quoteTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            quoteTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            quoteTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
//
        ])
        

    

        
    }
    
}
