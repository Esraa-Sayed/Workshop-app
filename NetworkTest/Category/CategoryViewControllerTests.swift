//
//  CategoryViewControllerTests.swift
//  OrderAppTests
//
//  Created by Amr Hesham on 26/02/2022.
//  Copyright © 2022 admin. All rights reserved.
//

import XCTest
@testable import Workshop_app

class CategoryViewControllerTests: XCTestCase {
    private var sut: CategoriesTableViewController!
    
    override func setUp() {
        super.setUp()
        sut = CategoriesTableViewController()
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
    
    func testSut_whenViewDidLoadCalled_categoryPresenterIsSet() {
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertNotNil(sut.categoriesPresenter)
    }
    
    func testSut_startsWithEmptyTableView() {
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testSut_whenGetCategoriesAndReloadTableIsCalled_tableViewIsFilled() {
        let presenter = MockCategoryPresenter()
        sut.categoriesPresenter = presenter
        sut.loadViewIfNeeded()
        sut.updateUI()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), presenter.getCategoriesCount())
    }
    
    func testSut_whenCellForRowIsCalled_cellIsReturnedWithCorrectData() {
        // Given
        
        // To register the cell with the table view
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CategoriesTableViewController") as? CategoriesTableViewController
        
        sut.categoriesPresenter = MockCategoryPresenter()
        sut.categoriesPresenter.fetchCategoriesFromNetwork()

        
        // When
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertEqual(cell.textLabel?.text, "Desserts")
    }
    
    func testSut_whenSeguePerformed_MenuTableViewControllerIsPresented(){
        // To register the cell with the table view
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CategoriesTableViewController") as? CategoriesTableViewController
        sut.categoriesPresenter = MockCategoryPresenter()
        let window = UIWindow()
       
        window.rootViewController = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))

        sut.performSegue(withIdentifier: "CategoriesToMenuItemsSegue", sender: cell)
        RunLoop.current.run(until: Date())
        XCTAssertNotNil(sut.navigationController?.topViewController as? MenuTableViewController)
    }
}

class MockCategoryPresenter: CategoriesPresenterProtocol {
    
    var networkManager: NetworkService = MockNetworkManager(fileName: "")
    var categories: [String] = []
    
    func fetchCategoriesFromNetwork() {
        categories = ["Desserts", "Sides"]
    }
    func getCategoriesCount() -> Int {
        return 2
    }
    func getCategory(at index: Int) -> String {
        return index < categories.count ? categories[index] : ""
    }
    
    
}
