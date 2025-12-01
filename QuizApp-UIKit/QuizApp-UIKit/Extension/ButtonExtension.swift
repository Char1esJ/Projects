//
//  ButtonExtension.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

extension UIButton {
    static func make(
        title: String,
        fontSize: CGFloat = 0.02,
        weight: UIFont.Weight = .heavy,
        titleColor: UIColor = .white,
        backgroundColor: UIColor = UIColor(named: "LoginButtonColor") ?? .systemBlue,
        radius: CGFloat = 0.025,
        borderColor: CGColor = UIColor.white.cgColor,
        borderWidth: CGFloat = 0
    ) -> UIButton {
        let button = UIButton(type: .system)
        let screenHeight = UIScreen.main.bounds.height
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: screenHeight * fontSize, weight: weight)
        button.backgroundColor = backgroundColor
        button.clipsToBounds = true
        button.layer.borderColor = borderColor  //UIColor.white.cgColor
        button.layer.borderWidth = borderWidth
        
        button.layer.cornerRadius = screenHeight * radius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
