//
//  RegisterUserRequest.swift
//  Core
//
//  Created by Charles Janjgava on 11/16/25.
//

public struct RegisterUserRequest: Codable {
    public let fullName: String
    public let userName: String
    public let email: String
    public let password: String
    public let confirmPassword: String
    
    public init(fullName: String, userName: String, email: String, password: String, confirmPassword: String) {
        self.fullName = fullName
        self.userName = userName
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
