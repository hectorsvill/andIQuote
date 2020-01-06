//
//  UIView+screenShot.swift
//  andIQuote
//
//  Created by Hector on 1/5/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

extension UIView {
    func screenShot() -> UIImage{
        let render = UIGraphicsImageRenderer(size: bounds.size)
        return render.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}
