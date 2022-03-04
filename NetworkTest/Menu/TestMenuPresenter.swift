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
        sut = MenuPresenter(view: menuView, category: "entrees", networkService: MockNetworkManager(fileName: "Menu"))
    
    }

    override func tearDown(){
        sut = nil
        menuView = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSut_whenInitCalled_MenuViewIsSet() {
        
        // Then
        XCTAssertNotNil(sut.menuView)
    }
    func testSut_whenFetchMenuItemsCalled_menuItemsAreFilled() {
                
        // When
        sut.fetchMenuItems()
        // Then
        XCTAssertNotEqual(sut.menuItems, [])
    }
    
    func testSut_FetchMenuItemsCalled_correctMenuItemIsReturned() {
        
        // Given
        sut.fetchMenuItems()
        
        // When
        let firstMenuItem = sut.menuItems?.first?.name
        
        // Then
        XCTAssertEqual(firstMenuItem, "Spaghetti and Meatballs")
    }
    
    func testSut_whenFetchMenuItemsCalled_correctMenuItemsCountReturned() {
        sut.fetchMenuItems()
       
        // When
        let menuListCount = sut.menuItems?.count
        
        // Then
        XCTAssertEqual(menuListCount, 6)

    }
    
    func testSut_whenGetCategoriesCalledWithFailure_categoriesStillEmpty() {
        // Given
        sut = MenuPresenter(view: menuView, category: "entrees", networkService: MockNetworkManager(fileName: "Error"))
        
        // Then
        sut.fetchMenuItems()
        
        // Then
        XCTAssertNil(sut.menuItems)

    }

}
