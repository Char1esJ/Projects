//
//  LocalizationManager.swift
//  Wazappp
//
//  Created by Edgar on 15.11.25.
//

import Foundation

final class LocalizationManager {
    static let shared = LocalizationManager()
    
    static let languageDidChangeNotification = Notification.Name("LanguageDidChange")
    
    enum Language: String, CaseIterable {
        case english = "en"
        case georgian = "ka"
        
        var displayName: String {
            switch self {
            case .english:
                return "English"
            case .georgian:
                return "ქართული"
            }
        }
        
        var code: String {
            return self.rawValue
        }
    }
    
    private var bundle: Bundle?
    private let userDefaultsKey = "AppLanguage"
    
    var currentLanguage: Language {
        get {
            guard let languageCode = UserDefaults.standard.string(forKey: userDefaultsKey),
                  let language = Language(rawValue: languageCode) else {
                return .english
            }
            return language
        }
        set {
            guard newValue != currentLanguage else { return }
            
            UserDefaults.standard.set(newValue.rawValue, forKey: userDefaultsKey)
            UserDefaults.standard.synchronize()
            
            setLanguage(newValue)
            
            NotificationCenter.default.post(name: LocalizationManager.languageDidChangeNotification, object: nil)
        }
    }
    
    private init() {
        setLanguage(currentLanguage)
    }
    
    private func setLanguage(_ language: Language) {
        guard let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            self.bundle = nil
            return
        }
        self.bundle = bundle
    }
    
    func localizedString(for key: String) -> String {
        guard let bundle = bundle else {
            return NSLocalizedString(key, comment: "")
        }
        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }
}

