//
//  NetworkTest.swift
//  HeropediaTests
//
//  Created by Alexandre Azevedo on 14/12/20.
//

import XCTest
@testable import Heropedia

class NetworkTest: XCTestCase {

    var systemUnderTest: HeroDataSource!
    
    override func setUpWithError() throws {
        systemUnderTest = HeroAPISource(requestMaker: MockHeroRequestMaker())
    }
    
    func testGetItems() {
        let expectation = XCTestExpectation(description: "response")
        systemUnderTest.getItems(page: 0, completion: { heroes, _ in
            XCTAssertNotNil(heroes)
            XCTAssertGreaterThan(heroes?.count ?? 0, 0)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetDetail() {
        let expectation = XCTestExpectation(description: "response")
        systemUnderTest.getItems(page: 0, completion: { hero, _, _ in
            XCTAssertNotNil(hero)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testfowardsError() {
        systemUnderTest = HeroAPISource(requestMaker: MockHeroRequestMaker(returnError: true))
        let expectation = XCTestExpectation(description: "response")
        systemUnderTest.getItems(page: 0, completion: { _, error, _ in
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 2)
    }
}
