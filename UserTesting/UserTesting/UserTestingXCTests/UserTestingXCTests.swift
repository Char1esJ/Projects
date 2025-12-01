//
//  UserTestingXCTests.swift
//  UserTestingXCTests
//
//  Created by Charles Janjgava on 11/12/25.
//

import XCTest
@testable import UserTesting

final class UserTestingXCTests: XCTestCase {
    
    var sut: UserViewModel!
    var user: User!
    
    override func setUpWithError() throws {
        user = User(
            gender: "male",
            name: Name(title: "Mr", first: "Christian", last: "Nielsen"),
            email: "christian.nielsen@example.com",
            picture: Picture(
                large: "https://randomuser.me/api/portraits/men/25.jpg",
                medium: "https://randomuser.me/api/portraits/med/men/25.jpg",
                thumbnail: "https://randomuser.me/api/portraits/thumb/men/25.jpg"
            ),
            nat: "DK",
            cell: "85537737",
            phone: "57231440"
        )
        
        sut = UserViewModel(user: user)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        user = nil
    }
    
    func testFullnameValidFormat() {
        let returnedResult = sut.fullName
        let expectedResult = ("\(user.name.title) \(user.name.first) \(user.name.last)")
        
        XCTAssertEqual(returnedResult, expectedResult, "Invalid Name Formating!")
    }
    
    func testEmptyFullName() {
        let emptyFullName = User(
            gender: user.gender,
            name: Name(title: "", first: "", last: ""),
            email: user.email,
            picture: user.picture,
            nat: user.nat,
            cell: user.cell,
            phone: user.phone
        )
        
        sut = UserViewModel(user: emptyFullName)
        let returnedResult = sut.fullName
        let expectedResult = ("")
        
        XCTAssertEqual(returnedResult, expectedResult)
    }
    
    func testContactNumberValidFormat() {
        let returnedResult = sut.contactNumber
        let expectedResult = ("\(user.cell) / \(user.phone)")
        
        XCTAssertEqual(returnedResult, expectedResult, "Invalid ContactNumber Formating!")
    }
    
    func testIFContactNumberHasEmptyCell() {
        let userWithoutCell = User(
            gender: user.gender,
            name: user.name,
            email: user.email,
            picture: user.picture,
            nat: user.nat,
            cell: "",
            phone: user.phone
        )
        
        sut = UserViewModel(user: userWithoutCell)
        let returnedResult = sut.contactNumber
        let expectedResult = ("/ \(userWithoutCell.phone)")
        
        XCTAssertEqual(returnedResult, expectedResult)
    }
    
    func testIFContactNumberISCompletelyEmpty() {
        let userWithoutCell = User(
            gender: user.gender,
            name: user.name,
            email: user.email,
            picture: user.picture,
            nat: user.nat,
            cell: "",
            phone: ""
        )
        
        sut = UserViewModel(user: userWithoutCell)
        let returnedResult = sut.contactNumber
        let expectedResult = ("/")
        
        XCTAssertEqual(returnedResult, expectedResult)
    }
    
    func testEmailValidFormat() {
        let returnedResult = sut.email
        let expectedResult = user.email
        
        XCTAssertEqual(returnedResult, expectedResult, "Invalid Email Formating!")
    }
    
    func testEmailNotEmpty() {
        XCTAssertFalse(sut.email.isEmpty)
    }

    func testIfEmailContainsSymbol() {
        XCTAssertTrue(sut.email.contains("@"))
    }
    
    func testShouldReturnOnlyThumbnailURL() {
        let returnedResult = sut.thumbnailImageUrl
        let expectedResult = URL(string: user.picture.thumbnail)
        
        XCTAssertEqual(returnedResult, expectedResult, "Invalid Thumbnail Url")
    }
    
    func testThumbnailWithEmptyURL() {
        let userWithInvalidURL = User(
            gender: user.gender,
            name: user.name,
            email: user.email,
            picture: Picture(large: user.picture.large, medium: user.picture.medium, thumbnail: ""),
            nat: user.nat,
            cell: user.cell,
            phone: user.phone
        )
        
        sut = UserViewModel(user: userWithInvalidURL)
        
        XCTAssertNil(sut.thumbnailImageUrl)
    }
    
    func testIfAllPropertiesReturnValues() {
        let returnedProperties: [Any] = [sut.contactNumber, sut.email, sut.fullName, sut.thumbnailImageUrl!]
        
        XCTAssertNotNil(returnedProperties, "Some Properties are nil.")
    }
}
