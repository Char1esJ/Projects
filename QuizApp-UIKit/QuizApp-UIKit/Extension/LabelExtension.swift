//
//  LabelExtension.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

extension UILabel {
    static func make(
        text: String,
        fontSize: CGFloat = 0.025,
        weight: UIFont.Weight = .medium,
        color: UIColor = .white,
        numberOfLines: Int = 1,
        alignment: NSTextAlignment = .left
    ) -> UILabel {
        let label = UILabel()
        let screenHeight = UIScreen.main.bounds.height
        label.text = text
        label.font = .systemFont(ofSize: screenHeight * fontSize, weight: weight)
        label.textColor = color
        label.numberOfLines = numberOfLines
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
