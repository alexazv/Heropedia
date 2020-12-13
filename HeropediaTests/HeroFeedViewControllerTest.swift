//
//  HeroFeedViewControllerTest.swift
//  BookClubTests
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import XCTest
@testable import Heropedia

class HeroFeedViewControllerTest: XCTestCase {

    var systemUnderTest: HeroFeedViewController?
    
    override func setUp() {
        super.setUp()
        systemUnderTest = HeroFeedViewController.instantiate()
        _ = systemUnderTest?.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSUT_CanInstantiateViewController() {
        
        XCTAssertNotNil(systemUnderTest)
    }
    
    func testSUT_CollectionViewIsNotNilAfterViewDidLoad() {
        
        XCTAssertNotNil(systemUnderTest?.collectionView)
    }
    
    func testSUT_ShouldSetCollectionViewDataSource() {
        XCTAssertNotNil(systemUnderTest?.collectionView?.dataSource)
    }
    
    func testSUT_ConformsToCollectionViewDataSource() {
        XCTAssert(systemUnderTest.self?.conforms(to: UICollectionViewDataSource.self) ?? false)
        XCTAssert(systemUnderTest?.responds(to: #selector(systemUnderTest?.collectionView(_:numberOfItemsInSection:))) ?? false)
        XCTAssert(systemUnderTest?.responds(to: #selector(systemUnderTest!.collectionView(_:cellForItemAt:))) ?? false)
    }
    
    func testSUT_ShouldSetCollectionViewDelegate() {
        
        XCTAssertNotNil(systemUnderTest?.collectionView?.delegate)
    }
    
    func testSUT_ConformsToCollectionViewDelegate() {
        XCTAssert(systemUnderTest.self?.conforms(to: UICollectionViewDelegate.self) ?? false)
        XCTAssert(systemUnderTest?.responds(to: #selector(systemUnderTest?.collectionView(_:didSelectItemAt:))) ?? false)
    }
}
