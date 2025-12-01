//
//  gradient1.swift
//  Assignment-N16
//
//  Created by Charles Janjgava on 10/11/25.
//

import UIKit

extension UIButton {
    func applyGradient(colors: [UIColor], cornerRadius: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.cornerRadius = cornerRadius
 
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
    }
}
