//
//  DatabaseManager.swift
//  Core
//
//  Created by kv on 17.11.25.
//
import Foundation
import FirebaseFirestore
import Combine

@MainActor
public class DatabaseManager {
    public static let shared = DatabaseManager()
    
    public init() {}
    
    let database = Firestore.firestore()
    
    public var updatedMessagesPublisher = PassthroughSubject<[Message], Error>()
    
    public func fetchAllMessages() async throws -> [Message] {
        let snapshot = try await database.collection("Messages").order(by: "createdAt", descending: false).getDocuments()
        let docs = snapshot.documents
        var messages: [Message] = []
        
        for doc in docs {
            let data = doc.data()
            
            guard let text = data["text"] as? String,
                  let imageName = data["imageName"] as? String,
                  let uid = data["uid"] as? String,
                  let timestamp = data["createdAt"] as? Timestamp,
                  let author = data["author"] as? String
            else {
                continue
            }
            
            let reactionsData = data["reactions"] as? [String: [String]] ?? [:]
            
            let message = Message(
                uid: uid,
                imageName: imageName,
                text: text,
                createdAt: timestamp.dateValue(),
                author: author,
                reactions: reactionsData,
                documentId: doc.documentID
            )
            messages.append(message)
        }
        listenToChangesInDatabase()
        
        return messages
    }
    
    public func sendMessageToDatabase(_ message: Message) async throws {
        let messageData = [
            "text": message.text,
            "uid": message.uid,
            "imageName": message.imageName,
            "createdAt": Timestamp(date: message.createdAt),
            "author": message.author,
            "reactions": message.reactions
        ] as [String: Any]
        
        try await database.collection("Messages").addDocument(data: messageData)
    }
    
    public func listenToChangesInDatabase() {
        database.collection("Messages").order(by: "createdAt", descending: false).addSnapshotListener { [weak self] snapshot, error in
            guard let documents = snapshot?.documents, error == nil, let self = self else {
                return
            }
            
            var messages: [Message] = []
            
            for doc in documents {
                let data = doc.data()
                
                guard let text = data["text"] as? String,
                      let imageName = data["imageName"] as? String,
                      let uid = data["uid"] as? String,
                      let timestamp = data["createdAt"] as? Timestamp,
                      let author = data["author"] as? String
                else {
                    continue
                }
                let reactionsData = data["reactions"] as? [String: [String]] ?? [:]
                
                let message = Message(
                    uid: uid,
                    imageName: imageName,
                    text: text,
                    createdAt: timestamp.dateValue(),
                    author: author,
                    reactions: reactionsData,
                    documentId: doc.documentID
                )
                messages.append(message)
            }
            
            self.updatedMessagesPublisher.send(messages)
        }
    }
    
    public func updateMessageReactions(documentId: String, reactions: [String: [String]]) async throws {
        try await database.collection("Messages").document(documentId).updateData(["reactions": reactions])
    }
}
