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
    
    
    override func setUp(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "MenuItemDetailViewController")
        sut.detailsPresenter = MockDetailsPresenter()
        let _ = self.sut.view
    }

    override func tearDown(){
        sut.detailsPresenter = nil
        sut = nil
    }

    func testSut_whenInitCalled_detailsPresenterIsSet() throws {
        XCTAssertNotNil(sut.detailsPresenter)
    }
    
    func testSut_whenViewIsLoaded_nameLabelIsSet() throws {
        sut.loadViewIfNeeded()
        let text = sut.nameLabel.text
        XCTAssert(text == sut.detailsPresenter?.menuItem?.name)
    }
    
    func testSut_whenAddIsTapped_itemIsAddedToOrder() throws {
        sut.loadViewIfNeeded()
        sut.addButton.sendActions(for: .touchUpInside)
        RunLoop.current.run(until: Date())
        XCTAssert(sut.detailsPresenter?.menuItem?.id == sut.detailsPresenter?.addItemToOrder().id)
    }
}


class MockDetailsPresenter: DetailsPresenterProtocol {
    var menuItem: MenuItem?
    var networkService: NetworkService!
    
    init(networkService: NetworkService = MenuController.shared) {
        menuItem = MenuItem(category: "Desserts", id: 1, imageURL: "image1", name: "Konafa", itemDescription: "Description", price: 25)
        self.networkService = networkService
    }
    
    func addItemToOrder() -> MenuItem {
        return self.menuItem!
    }
    
}
