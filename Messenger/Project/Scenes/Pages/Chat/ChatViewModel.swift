//
//  ChatViewModel.swift
//  Project
//
//  Created by kv on 15.11.25.
//

import Foundation
import Core
import Combine

@MainActor
class ChatViewModel {
    
    weak var coordinator: MainCoordinator?
    private(set) var currentUser: User?
    
    var databaseMessages: [Message] = []
    var tokens: Set<AnyCancellable> = []
    
    let userReadyPublisher = CurrentValueSubject<User?, Never>(nil)
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        observeUserChanges()
        
        if let user = AuthService.shared.getCurrentUser() {
            self.currentUser = user
            userReadyPublisher.send(user)
        }
    }
    
    private func observeUserChanges() {
        AuthService.shared.$currentUser
            .compactMap { $0 }
            .sink { [weak self] user in
                guard let self = self else { return }
                self.currentUser = user
                self.userReadyPublisher.send(user)
            }
            .store(in: &tokens)
    }
    
    func settingsButtonTapped() {
        coordinator?.navigateToProfilePage()
    }
    
    func toggleReaction(to messageDocumentId: String, emoji: String) {
        guard let index = databaseMessages.firstIndex(where: { $0.documentId == messageDocumentId }),
              let currentUID = currentUser?.userUID,
              let docId = databaseMessages[index].documentId else { return }
        
        var updatedReactions = databaseMessages[index].reactions
        
        if var users = updatedReactions[emoji] {
            if users.contains(currentUID) {
                users.removeAll { $0 == currentUID }
                if users.isEmpty {
                    updatedReactions.removeValue(forKey: emoji)
                } else {
                    updatedReactions[emoji] = users
                }
            } else {
                users.append(currentUID)
                updatedReactions[emoji] = users
            }
        } else {
            updatedReactions[emoji] = [currentUID]
        }
        
        databaseMessages[index].reactions = updatedReactions
        
        Task {
            do {
                try await DatabaseManager.shared.updateMessageReactions(
                    documentId: docId,
                    reactions: updatedReactions
                )
            } catch {
                print("Failed to update reactions: \(error.localizedDescription)")
            }
        }
    }
}

