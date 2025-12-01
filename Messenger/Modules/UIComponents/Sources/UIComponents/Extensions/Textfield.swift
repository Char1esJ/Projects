//
//  Textfield.swift
//  UIComponents
//
//  Created by kv on 16.11.25.
//
import UIKit

extension UITextField {
    @objc func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        
        if let containerView = rightView,
           let button = containerView.viewWithTag(999) as? UIButton {
            button.isSelected = !isSecureTextEntry
        }
    }
}
