//
//  UIView+screenShot.swift
//  andIQuote
//
//  Created by Hector on 1/5/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

extension UIView {
    func screenShot() -> UIImage {
        let render = UIGraphicsImageRenderer(size: bounds.size)
        
        return render.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
    
    func setBackground(to backgroundString: String) {
        if backgroundString == "systemBackground" {
            backgroundColor = .systemBackground
        } else if backgroundString ==  "red" {
            backgroundColor = .systemRed
        } else if backgroundString == "green" {
            backgroundColor = .systemGreen
        } else if backgroundString ==  "blue" {
            backgroundColor = .systemBlue
        } else if backgroundString ==  "gray" {
            backgroundColor = .systemGray
        } else if backgroundString ==  "pink" {
            backgroundColor = .systemPink
        }else if backgroundString ==  "teal" {
            backgroundColor = .systemTeal
        } else if backgroundString == "indigo" {
            backgroundColor = .systemIndigo
        } else if backgroundString ==  "orange" {
            backgroundColor = .systemOrange
        } else if backgroundString == "yellow" {
            backgroundColor = .systemYellow
        } else if backgroundString ==  "purple" {
            backgroundColor = .systemPurple
        }
    }

    func impactGesture(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactFeedback = UIImpactFeedbackGenerator(style: style)
        impactFeedback.impactOccurred()
    }
}
