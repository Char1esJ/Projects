//
//  LoginUserRequest.swift
//  Core
//
//  Created by Charles Janjgava on 11/16/25.
//

public struct LoginUserRequest: Codable {
    public let email: String
    public let password: String
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
