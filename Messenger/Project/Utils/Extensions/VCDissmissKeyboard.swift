//
//  VCDissmissKeyboard.swift
//  Project
//
//  Created by Charles Janjgava on 11/16/25.
//

import UIKit

extension UIViewController {
    func setupTapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
