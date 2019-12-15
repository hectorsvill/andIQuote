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
    
    var quote: Quote? { didSet { setupView()} }

    var quoteTextView: UITextView {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.textAlignment = .justified
        textview.textColor = .label
        return textview
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func getAttributedText() -> NSAttributedString {
        guard let quote = quote else { return NSAttributedString(string: "") }
        let attributedString = NSMutableAttributedString(string: quote.str, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 24)])
        let author = quote.author ?? ""
        attributedString.append(NSAttributedString(string: "\n\n\(author)", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16)]))
        
        return attributedString
    }
    
    private func setupView() {
        let quoteContainerView = UIView()
        quoteContainerView.translatesAutoresizingMaskIntoConstraints = false
        quoteContainerView.backgroundColor = .red
        
        addSubview(quoteTextView)
        addSubview(quoteContainerView)
        quoteTextView.attributedText = getAttributedText()
        
//        NSLayoutConstraint.activate([
//            quoteContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            quoteContainerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
//            quoteContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            quoteContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//
//            quoteTextView.centerYAnchor.constraint(equalTo: quoteContainerView.centerYAnchor),
//            quoteTextView.centerXAnchor.constraint(equalTo: quoteContainerView.centerXAnchor),
//            quoteContainerView
//        ])
        
    

        
    }
    
}
