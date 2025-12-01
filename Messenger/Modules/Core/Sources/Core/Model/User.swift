//
//  User.swift
//  Core
//
//  Created by Charles Janjgava on 11/17/25.
//

public struct User: Codable {
    public let fullname: String
    public let username: String
    public let userUID: String
    public let profileImageName: String?
    
    public init(fullname: String, username: String, userUID: String, profileImageName: String? = nil) {
        self.fullname = fullname
        self.username = username
        self.userUID = userUID
        self.profileImageName = profileImageName
    }
}
