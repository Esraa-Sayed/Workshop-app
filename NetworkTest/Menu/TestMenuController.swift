//
//  TestMenuController.swift
//  NetworkTest
//
//  Created by esraa on 3/4/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import XCTest
@testable import Workshop_app

class TestMenuController: XCTestCase {
    private var sut: MenuTableViewController!
    
    override func setUp() {
        super.setUp()
        sut = MenuTableViewController()
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
    
    
    func testSut_startsWithEmptyTableView() {
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testSut_whenGetMenuItemsAndReloadTableIsCalled_tableViewIsFilled() {
        let presenter = MockMenuPresenter()
        sut.menuPresenter = presenter
        sut.loadViewIfNeeded()
        sut.updateUI(with: [])
        sut.stopIndicator()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), presenter.menuItems?.count)
    }
    
    func testSut_whenGetMenuItemsAndReloadTable_andDisplayingErrorMessage() {
        let presenter = MockMenuPresenter()
        sut.menuPresenter = presenter
        sut.loadViewIfNeeded()
        sut.updateUI(with: [])
        sut.displayError("errorrr", title: "errrror")
        sut.stopIndicator()
        
        XCTAssertEqual(sut.indicator.isAnimating, false)
    }
    func testSut_whenCellForRowIsCalled_cellIsReturnedWithCorrectData() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MenuTableViewController") as? MenuTableViewController
        sut.menuPresenter = MockMenuPresenter()
        sut.menuPresenter?.fetchMenuItems()
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(cell.textLabel?.text, "Spaghetti and Meatballs")
    }
    
    func testSut_whenSeguePerformed_ItemDetailsViewControllerIsPresented(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MenuTableViewController") as? MenuTableViewController
        sut.menuPresenter = MockMenuPresenter()
        let window = UIWindow()
        
        window.rootViewController = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        sut.performSegue(withIdentifier: "MenuItemToItemDetailsSegue", sender: cell)
        RunLoop.current.run(until: Date())
        XCTAssertNotNil(sut.navigationController?.topViewController as? MenuItemDetailViewController)
    }
}

class MockMenuPresenter: MenuPresenterProtocol {
    var category: String?
    
    var menuItems: [MenuItem]?
    
    var menuItem: MenuItem?
    
    
    var menuView: MenuViewProtocol?
    
    var networkManager = MockNetworkManager(fileName: "")
    
    func fetchMenuItems() {
        menuItems = []
        menuItem = MenuItem(category: "entrees",
                            id: 1,
                            imageURL: "http://localhost:8080/images/1.png",
                            name: "Spaghetti and Meatballs",
                            itemDescription: "Seasoned meatballs on top of freshly-made spaghetti. Served with a robust tomato sauce.",
                            price: 9)
        menuItems?.append(menuItem!)
    }
    
}
