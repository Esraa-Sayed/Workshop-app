//
//  TestMenu.swift
//  NetworkTest
//
//  Created by Youssef on 3/3/22.
//  Copyright © 2022 esraa. All rights reserved.
//
import XCTest
@testable import Workshop_app

class TestMenuPresenter: XCTestCase {

    private var sut: MenuPresenter!
    private var menuView: MockMenuView!
    
    
    override func setUp(){
        super.setUp()
        menuView = MockMenuView()
        sut = MenuPresenter(view: menuView, category: <#T##String#>, networkService: <#T##NetworkService#>)
        CategoryPresenter(networkManager: MockNetworkManager(fileName: "Categories"), view: categoryView)
    }

    override func tearDown(){
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
