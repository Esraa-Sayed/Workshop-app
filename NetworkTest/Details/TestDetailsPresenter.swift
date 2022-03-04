//
//  TestDetails.swift
//  NetworkTest
//
//  Created by Youssef on 3/3/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import XCTest
@testable import Workshop_app

class TestDetailsPresenter: XCTestCase {

    private var sut: MenuDetailsPresenter!
    private var detailsView: MockDetailsView!
    private var menuItem: MenuItem!
    
    
    override func setUp(){
        menuItem = MenuItem(category: "Desserts", id: 1, imageURL: "image1", name: "Konafa", itemDescription: "Description", price: 25)
        detailsView = MockDetailsView()
        sut = MenuDetailsPresenter(view: detailsView, menuItem: menuItem)
        
    }

    override func tearDown(){
        sut = nil
        detailsView = nil
        menuItem = nil
    }

    func testSut_whenInitCalled_detailsViewIsSet() throws {
        XCTAssertNotNil(sut.detailsView)
    }
    
    func testSut_whenInitCalled_menuItemIsSet() throws {
        XCTAssertNotNil(sut.menuItem)
    }
    
    func testSut_whenInitCalled_networkServiceIsSet() throws {
        XCTAssertNotNil(sut.networkService)
    }
    
    func testSut_whenAddItemToOrder_itemIsAdded() throws {
        
        sut.addItemToOrder()
        let count = sut.networkService.order.menuItems.count
        XCTAssert(sut.networkService.order.menuItems[count - 1].id == menuItem.id)
    }
    

    

}

class MockDetailsView: DetailsViewProtocol {
    func updateUI() {
        print("UI Updated")
    }
}
