//
//  File.swift
//  Wazappp
//
//  Created by Edgar on 15.11.25.
//


import Foundation

extension String {
    var localized: String {
        return LocalizationManager.shared.localizedString(for: self)
    }
    
    func localized(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
