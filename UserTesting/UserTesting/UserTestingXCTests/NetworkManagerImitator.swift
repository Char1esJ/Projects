//
//  NetworkManagerImitator.swift
//  UserTesting
//
//  Created by Charles Janjgava on 11/13/25.
//

import UIKit
import XCTest
@testable import UserTesting

final class NetworkManagerImitator: NetworkServiceProtocol {
    var users: [User] = []
    var shouldFail = false
    var customMockJSON: String?
    
    func fetchUsers(withLimit limit: Int = 1, completionHandler: @escaping ([User]) -> Void) {
        if shouldFail {
            completionHandler([])
            return
        }
        
        let jsonString = customMockJSON ?? User.jsonMock
        
        guard let mockJson = jsonString.data(using: .utf8) else {
            completionHandler([])
            return
        }
        
        do {
            let userList = try JSONDecoder().decode(UserList.self, from: mockJson)
            completionHandler(userList.results)
        } catch {
            completionHandler([])
        }
    }
}
