//
//  ApiTests.swift
//  AmicusTests
//
//  Created by Nils Theres on 06.06.22.
//

import XCTest

@testable import Amicus

class ApiTests: XCTestCase {
    func testGetCategories() async throws {
        let categories = try await WebClient.localhost.retrieveCategories()
        XCTAssertGreaterThan(categories.count, 0)
    }
    
    func testGoodLogin() async throws {
        let login = try await WebClient.localhost.login(email: "n@n.com", password: "cccccccc")
        XCTAssertNotNil(login)
    }
    
    func testBadLogin() async throws {
        do {
            let _ = try await WebClient.localhost.login(email: "n@n.com", password: "bad password")
            XCTFail("This call should throw an error.")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, "Amicus.RequestError")
            XCTAssertEqual(error.code, 3)
        }
    }
}
