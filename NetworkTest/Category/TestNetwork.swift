//
//  TestNetwork.swift
//  NetworkTest
//
//  Created by Youssef on 3/5/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import XCTest

@testable import Workshop_app

class TestNetwork: XCTestCase {
    
    var nw: NetworkService!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        nw = MenuController.shared
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCategoriesAPI() {
        let ex = expectation(description: "Waiting for categories response")
        nw.fetchCategories(completion: { (result) in
            var count = 0
            do {
                count = try result.get()?.categories.count as! Int
            } catch {
                print("error")
            }
            
            
            XCTAssert(count > 0, "Categories API Failed")
            ex.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testMenuItemsAPI() {
        let ex = expectation(description: "Waiting for menu items response")
        nw.fetchMenuItems(forCategory: "appetizers", completion: { (result) in
            var count = 0
            do {
                count = try result.get()?.count as! Int
            } catch {
                print("error")
            }
            
            
            XCTAssertNotEqual(count, 0)
            ex.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testItemsDetailsAPI() {
        let ex = expectation(description: "Waiting for menu items response")
        nw.fetchMenuItems(forCategory: "appetizers", completion: { (result) in
            var first: String!
            do {
                first = try result.get()?[0].name as! String
            } catch {
                print("error")
            }
            
            
            XCTAssertEqual(first, "Ham and mushroom ravioli")
            ex.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSubmitOrderAPI() {
        let ex = expectation(description: "Waiting for menu items response")
        nw.submitOrder(forMenuIDs: [1, 2, 3]) { (result) in
            var time = 0
            do {
                time = try result.get()
            } catch {
                print("error")
            }
            XCTAssertNotEqual(time, 0)
            ex.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    

}
