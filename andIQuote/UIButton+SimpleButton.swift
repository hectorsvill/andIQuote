//
//  UIButton+SimpleButton.swift
//  andIQuote
//
//  Created by Hector on 12/31/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import UIKit

extension UIButton {
    func sfImageButton(systemName: String, configuration: UIImage.SymbolConfiguration = UIImage().mainViewSymbolConfig()) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        
        let image = UIImage(systemName: systemName, withConfiguration:  configuration)
        button.setImage(image, for: .normal)
        
        return button
    }
    
    
}
