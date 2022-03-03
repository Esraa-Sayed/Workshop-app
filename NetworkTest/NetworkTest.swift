//
//  NetworkTest.swift
//  NetworkTest
//
//  Created by Youssef on 2/26/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import XCTest
@testable import Workshop_app

class NetworkTest: XCTestCase {

    var networkService: NetworkService = MenuController.shared
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCategories() throws {
        let ex = expectation(description: "Waiting for categories response")
        networkService.fetchCategories( completion: { (result) in
            var success: Bool
            switch result {
            case .success( _):
                success = true
            case .failure( _):
                success = false
            }
            XCTAssert(success == true, "Categories Failed")
            ex.fulfill()
        })
        
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
