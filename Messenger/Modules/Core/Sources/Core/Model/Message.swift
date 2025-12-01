//
//  Message.swift
//  Core
//
//  Created by kv on 18.11.25.
//

import Foundation

public struct Message: Codable {
    public let text: String
    public let imageName: String
    public let uid: String
    public let createdAt: Date
    public let author: String
    public var reactions: [String: [String]]
    public var documentId: String?
    
    public init(uid: String, imageName: String, text: String, createdAt: Date, author: String, reactions: [String: [String]] = [:], documentId: String? = nil) {
        self.uid = uid
        self.imageName = imageName
        self.text = text
        self.createdAt = createdAt
        self.author = author
        self.reactions = reactions
        self.documentId = documentId
    }
    
    public func reactionCount(for emoji: String) -> Int {
        return reactions[emoji]?.count ?? 0
    }
    
    public func hasUserReacted(emoji: String, userId: String) -> Bool {
        return reactions[emoji]?.contains(userId) ?? false
    }
}
