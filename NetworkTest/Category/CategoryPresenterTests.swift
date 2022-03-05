//
//  OrderAppTests.swift
//  OrderAppTests
//
//  Created by Amr Hesham on 26/02/2022.
//  Copyright © 2022 admin. All rights reserved.
//

import XCTest
@testable import Workshop_app

class CategoryPresenterTests: XCTestCase {
    private var sut: CategoriesPresenter!
    private var categoryView: MockCategoryView!
    
    override func setUp() {
        super.setUp()
        categoryView = MockCategoryView()
        sut  = CategoriesPresenter(view: categoryView, networkService: MockNetworkManager(fileName: "Categories"))
    }
    
    override func tearDown() {
        sut = nil
        categoryView = nil
        
        super.tearDown()
    }
    
    func testSut_whenInitCalled_categoryViewIsSet() {
        
        // Then
        XCTAssertNotNil(sut.categoriesView)
    }
    
    func testSut_whenGetCategoriesCalled_categoriesAreFilled() {
              
        
        // When
        sut.fetchCategoriesFromNetwork()
        
        // Then
        XCTAssertNotEqual(sut.categories, [])
    }
    
    func testSut_whengetCategoryAtIndexCalled_correctCategoryIsReturned() {
        
        // Given
        sut.fetchCategoriesFromNetwork()
        
        // When
        let firstCategory = sut.getCategory(at: 0)
        
        // Then
        XCTAssertEqual(firstCategory, "Desserts")
    }
    
    func testSut_whengetCategoryCountCalled_correctCategoryIsReturned() {
        
        // Given
        sut.fetchCategoriesFromNetwork()
        
        // When
        let categoryListCount = sut.getCategoriesCount()
        
        // Then
        XCTAssertEqual(categoryListCount, 3)

    }
    
    func testSut_whenGetCategoriesCalledWithFailure_categoriesStillEmpty() {
        // Given
        sut = CategoriesPresenter(view: categoryView, networkService: MockNetworkManager(fileName: "Error"))
        // Then
        sut.fetchCategoriesFromNetwork()
        
        // Then
        XCTAssertEqual(sut.categories, [])

    }
}

class MockCategoryView: CategoriesViewProtocol {
    func startIndicator() {
    
    }
    
    func stopIndicator() {
        
    }
    
    func updateUI() {
        
    }
    
    func displayError(_ error: String, title: String) {
        
    }
}
