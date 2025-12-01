//
//  Localization+VC.swift
//  Project
//
//  Created by kv on 16.11.25.
//

import UIKit

protocol Localizable: AnyObject {
    func updateLocalizedStrings()
}

extension Localizable where Self: UIViewController {
    
    func setupLocalizationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UIViewController.localizationDidChange),
            name: LocalizationManager.languageDidChangeNotification,
            object: nil
        )
    }
    
    func removeLocalizationObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: LocalizationManager.languageDidChangeNotification,
            object: nil
        )
    }
}

extension UIViewController {
    
    @objc func localizationDidChange() {
        guard let localizable = self as? Localizable else { return }
        localizable.updateLocalizedStrings()
    }
}
