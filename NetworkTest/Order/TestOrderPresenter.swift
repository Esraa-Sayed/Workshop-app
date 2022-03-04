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
        sut.uploadOrder(menuIds: [1,2,3,4,5])
        
        // Then
        XCTAssertNotEqual(sut.minutesToPrepare,nil)
    }
    func testSut_whenGetOrderCalled_ItemCountAreFilled() {
        let count:Int = sut.getMenuItemsCount()
        XCTAssertNotEqual(count,nil)
    }
    func testSut_whenGetOrderCalled_OrderTotalAreFilled() {
        let count = sut.getOrderTotal()
        XCTAssertNotEqual(count,nil)
    }
    func testSut_whenGetOrderCalled_NotificationNameFilled() {
        let notify = sut.getNotifyName()
        XCTAssertNotEqual(notify,nil)
    }
    func testSut_whenGetCategoriesCalledWithFailure_categoriesStillEmpty() {
        // Given
        sut = OrdersPresenter(view: orderView , networkService: MockNetworkManager(fileName: "Error"))
        // Then
        sut.uploadOrder()
        
        // Then
        XCTAssertEqual(sut.minutesToPrepare,nil)

    }
}
