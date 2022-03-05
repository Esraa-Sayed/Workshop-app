//
//  CategoriesPresenter.swift
//  Workshop app
//
//  Created by Youssef on 2/25/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation

protocol CategoriesPresenterProtocol {
    func getCategoriesCount() -> Int
    func getCategory(at index: Int) -> String
    func fetchCategoriesFromNetwork()
}

class CategoriesPresenter: CategoriesPresenterProtocol {
    
    lazy var categories: [String] = []
    weak var categoriesView: CategoriesViewProtocol!
    let networkService: NetworkService!
    
    
    init(view: CategoriesViewProtocol, networkService: NetworkService = MenuController.shared) {
        categoriesView = view
        self.networkService = networkService
    }
    
    func fetchCategoriesFromNetwork() {
        networkService.fetchCategories { [weak self] (result)  in
                switch result {
                case .success(let categories):
                    self?.categories = categories?.categories as! [String]
                    DispatchQueue.main.async {
                        self?.categoriesView.updateUI()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.categoriesView.displayError(error, title: "Failed to Fetch Categories")
                    }
                }
                DispatchQueue.main.async {
                    self?.categoriesView.stopIndicator()
                }
            }
        }
    
    func getCategoriesCount() -> Int {
        return categories.count
    }
    
    func getCategory(at index: Int) -> String {
        if index < categories.count {
            return categories[index]
        }
        return ""
    }
    
    
    
    
}
