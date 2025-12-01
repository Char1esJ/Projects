//
//  TextFieldExtension.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

extension UITextField {
    static func make(
        placeholder: String? = nil,
        fontSize: CGFloat = 0.018,
        textColor: UIColor = .label,
        borderColor: UIColor = .white,
        borderWidth: CGFloat = 0.6,
        cornerRadius: CGFloat = 0.017
    ) -> UITextField {
        let textField = UITextField()
        let screenHeight = UIScreen.main.bounds.height
        
        textField.placeholder = placeholder
        textField.font = .systemFont(ofSize: screenHeight * fontSize)
        textField.textColor = textColor
    
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = borderWidth
        textField.clipsToBounds = true
 
        textField.layer.cornerRadius = screenHeight * cornerRadius
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
