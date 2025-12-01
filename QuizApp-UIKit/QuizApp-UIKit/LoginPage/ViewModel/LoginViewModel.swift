//
//  LoginViewModel.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/30/25.
//

import Foundation

class LoginViewModel {
    
    // MARK: - Properties
    
    private let keychainManager = KeychainManager()
    
    func isUserLoggedIn() -> Bool {
        return getPassword() != nil
    }
    
    func getPassword() -> String? {
        guard let data = keychainManager.get(service: "LoginService", account: "user") else {
            return nil
        }
        return String(decoding: data, as: UTF8.self)
    }
    
    func savePassword(username: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let username = username, !username.isEmpty else {
            return false
        }
        
        guard let password = password, !password.isEmpty else {
            return false
        }
        
        guard let confirmPassword = confirmPassword, !confirmPassword.isEmpty else {
            return false
        }
        
        guard password == confirmPassword else {
            return false
        }
        
        guard let passwordData = password.data(using: .utf8) else {
            return false
        }
        
        do {
            try keychainManager.save(
                service: "LoginService",
                account: "user",
                password: passwordData
            )
            return true
        } catch {
            return false
        }
    }
}
