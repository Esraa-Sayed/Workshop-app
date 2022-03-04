//
//  TestOrder.swift
//  NetworkTest
//
//  Created by Youssef on 3/3/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import XCTest
@testable import Workshop_app
class TestOrder: XCTestCase {
    private var sut:OrdersPresenter!
    private var orderView:OrdersTableViewController!
    override func setUp(){
        super.setUp()
        orderView = OrdersTableViewController()
        sut = OrdersPresenter(view: orderView , networkService: MockNetworkManager(fileName: "Order"))
    }

    override func tearDown(){
        sut = nil
        orderView = nil
    }

   func testSut_whenInitCalled_categoryViewIsSet() {
       
       // Then
    XCTAssertNotNil(sut.orderView)
   }
    func testSut_whenGetOrderCalled_PreperdTimeAreFilled() {
                
        // When
        sut.uploadOrder()
        
        // Then
        XCTAssertNotEqual(sut.minutesToPrepare,nil)
    }

}
