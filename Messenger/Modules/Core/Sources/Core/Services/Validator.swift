//
//  Validator.swift
//  firebaseTest
//
//  Created by Charles Janjgava on 11/16/25.
//

import Foundation

public class Validator {
    public static func isValidEmail(for email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    public static func isValidUserName(for userName: String) -> Bool {
        let userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
        let usernameRegEx = "^\\w{4,24}$"
        let userNamePred = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        return userNamePred.evaluate(with: userName)
    }
    
    public static func isValidFullName(for fullName: String) -> Bool {
        let fullName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        let fullNameRegEx = #"^[a-zA-Z\s'\-]{2,100}$"#
        let fullNamePred = NSPredicate(format: "SELF MATCHES %@", fullNameRegEx)
        return fullNamePred.evaluate(with: fullName)
    }
    
    public static func isValidPassword(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&._]).{6,32}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
