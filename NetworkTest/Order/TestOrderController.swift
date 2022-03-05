//
//  TestOrderController.swift
//  NetworkTest
//
//  Created by esraa on 3/4/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import XCTest
@testable import Workshop_app
class TestOrderController: XCTestCase {

    private var sut: OrdersTableViewController!
       
       override func setUp() {
           super.setUp()
           sut = OrdersTableViewController()
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          sut = storyboard.instantiateViewController(withIdentifier: "OrdersTableViewController") as? OrdersTableViewController
        UIApplication.shared.keyWindow?.rootViewController = sut

       }
       
       override func tearDown() {
           sut = nil
           super.tearDown()
       }
       
       func testSUT_ShouldSetTableViewDelegate() {
         
         XCTAssertNotNil(sut.tableView.delegate)
       }
       
       func testSUT_ShouldSetTableViewDatasource() {
         
         XCTAssertNotNil(sut.tableView.dataSource)
       }
    func testSut_whenViewDidLoadCalled_OrderPresenterIsSet() {
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertNotNil(sut.ordersPresenter)
    }
    func testSut_startsWithEmptyTableView() {
           XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
       }
       
       func testSut_whenGetCategoriesAndReloadTableIsCalled_tableViewIsFilled() {
           let presenter = MockOrderPresenter()
            sut.notify()
           sut.ordersPresenter = presenter
          
           sut.reloadTableView()
           XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), presenter.getMenuItemsCount())
       }
    func testSut_displayEstimatedTime(){
          // To register the cell with the table view
          
          sut.ordersPresenter = MockOrderPresenter()

        sut.displayEstimatedTime(minutesToPrepare: 5)
        RunLoop.current.run(until: Date())
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
        XCTAssertEqual(sut.presentedViewController?.title, "Order Confirmed")
      }
    func testSut_displayError()
    {
        sut.ordersPresenter = MockOrderPresenter()
        sut.displayError("error", title: "fail")
        RunLoop.current.run(until: Date())
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
        XCTAssertEqual(sut.presentedViewController?.title, "fail")
    }
}
