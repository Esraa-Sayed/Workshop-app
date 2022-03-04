//
//  TestDetailsViewController.swift
//  NetworkTest
//
//  Created by Youssef on 3/4/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import XCTest
@testable import Workshop_app

class TestDetailsViewController: XCTestCase {

    private var sut: MenuItemDetailViewController!
    private var menuItem: MenuItem!
    
    override func setUpWithError() throws {
        menuItem = MenuItem(category: "Desserts", id: 1, imageURL: "image1", name: "Konafa", itemDescription: "Description", price: 25)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "MenuItemDetailViewController") as? MenuItemDetailViewController
        sut.detailsPresenter = MockDetailsPresenter()
    }

    override func tearDownWithError() throws {
        
    }

    func testSut_whenInitCalled_detailsPresenterIsSet() throws {
        XCTAssertNotNil(sut.detailsPresenter)
    }
    
    func testSut_whenViewIsLoaded_nameLabelIsSet() throws {
        sut.loadViewIfNeeded()
        XCTAssert(sut.nameLabel.text == menuItem.name)
    }
//    
//    func testSut_whenAddIsTapped_itemIsAddedToOrder() throws {
//        sut.orderButtonTapped(<#UIButton#>)
//        RunLoop.current.run(until: Date())
//        XCTAssert(sut.detailsPresenter?.menuItem?.id == menuItem.id)
//    }
}


class MockDetailsPresenter: DetailsPresenterProtocol {
    var menuItem: MenuItem?
    
    
    func addItemToOrder() {
    }
    
    
}
