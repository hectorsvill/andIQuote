//
//  NSAttributeString+Strings.swift
//  andIQuote
//
//  Created by s on 1/25/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

extension NSAttributedString {
    func andiquoteString() -> NSAttributedString {
        
        let attributes2 = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        
        let attributes3 = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        
        let aString = NSMutableAttributedString(string: "and", attributes: attributes2)
        aString.append(NSAttributedString(string: "I", attributes: attributes2))
        aString.append(NSAttributedString(string: "Quote", attributes: attributes3))

        return aString
    }
}
