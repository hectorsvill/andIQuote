//
//  NSMutableAttributedString+quoteAttributed.swift
//  andIQuote
//
//  Created by s on 4/17/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit


public extension NSMutableAttributedString {
    static func attributedString(_ quote: Quote, font: CGFloat, quoteForegroundColor: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: quote.body!, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: font), NSAttributedString.Key.foregroundColor: quoteForegroundColor])
        attributedString.append(NSAttributedString(string: "\n\n\(quote.author!)", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: font -  4), NSAttributedString.Key.foregroundColor: quoteForegroundColor]))
        return attributedString
    }
}
