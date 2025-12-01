//
//  NetworkTests.swift
//  UserTestingXCTests
//
//  Created by Charles Janjgava on 11/12/25.
//

import XCTest
@testable import UserTesting

final class NetworkTests: XCTestCase {
    var sut: NetworkManagerImitator!
    
    override func setUp() {
        super.setUp()
        sut = NetworkManagerImitator()
    }
    
    override func tearDown() {
        sut.customMockJSON = nil
        sut = nil
        super.tearDown()
    }
    
    func testMockFetchUsersReturnsData() {
        let expectation = expectation(description: "Fetched Mock User")
        var resultUsers: [User] = []
        
        sut.fetchUsers(withLimit: 1) { users in
            resultUsers = users
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
        XCTAssertFalse(resultUsers.isEmpty)
    }
    
    func testMockUserDataIsValid() {
        let expectation = expectation(description: "Validate user data")
        var resultUsers: [User] = []
        
        sut.fetchUsers(withLimit: 1) { users in
            resultUsers = users
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
        
        guard let firstUser = resultUsers.first else {
            XCTFail("No users returned")
            return
        }
        
        XCTAssertEqual(firstUser.name.first, "Christian")
        XCTAssertEqual(firstUser.name.last, "Nielsen")
        XCTAssertEqual(firstUser.email, "christian.nielsen@example.com")
        XCTAssertEqual(firstUser.nat, "DK")
    }
    
    func testMockJsonDecoding() throws {
        guard let mockJSON = User.jsonMock.data(using: .utf8) else {
            XCTFail("Converting JSON to data Failed.")
            return
        }
        
        let userList = try JSONDecoder().decode(UserList.self, from: mockJSON)
        
        XCTAssertEqual(userList.results.count, 1)
        XCTAssertEqual(userList.results[0].name.first, "Christian")
    }
    
    func testMockFetchFailure() {
        let expectation = expectation(description: "Failure case")
        var resultUsers: [User] = []
        
        sut.shouldFail = true
        
        sut.fetchUsers { user in
            resultUsers = user
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
        XCTAssertTrue(resultUsers.isEmpty)
    }
    
    func testIncorrectMockJSONDecoding() {
        let expectation = expectation(description: "Incorrect JSON")
        var resultUsers: [User] = []
        
        sut.customMockJSON = """
            {
                "incorrect": "JSON"
            }
            """
        
        sut.fetchUsers { user in
            resultUsers = user
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
        XCTAssertTrue(resultUsers.isEmpty)
    }
    
    func testEmptyMockJSON() {
        let expectation = expectation(description: "Empty JSON")
        var resultUsers: [User] = []
        
        sut.customMockJSON = """
            {
                "results": []
            }
            """
        
        sut.fetchUsers { user in
            resultUsers = user
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
        XCTAssertTrue(resultUsers.isEmpty)
    }
    
    func testIncompleteMockJSON() {
        let expectation = expectation(description: "Incomplete JSON")
        var resultUsers: [User] = []
        
        sut.customMockJSON = """
            {
                "results": [
                    {
                        "gender": "male",
                        "name": {
                            "title": "Mr"
                        }
                    }
                ]
            }
            """
        
        sut.fetchUsers { user in
            resultUsers = user
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
        XCTAssertTrue(resultUsers.isEmpty)
    }
}
