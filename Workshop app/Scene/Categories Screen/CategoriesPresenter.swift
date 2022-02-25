//
//  CategoriesPresenter.swift
//  Workshop app
//
//  Created by Youssef on 2/25/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation

protocol CategoriesPresenterProtocol {
    var categories: [String]! {get set}
    func fetchCategoriesFromNetwork()
}

class CategoriesPresenter: CategoriesPresenterProtocol {
    
    var categories: [String]!
    private weak var categoriesView: CategoriesViewProtocol!
    
    
    init(view: CategoriesViewProtocol) {
        categoriesView = view
    }
    
    func fetchCategoriesFromNetwork() {
        MenuController.shared.fetchCategories { [weak self] (result)  in
            
                switch result {
                case .success(let categories):
                    self?.categories = categories
                    DispatchQueue.main.async {
                        self?.categoriesView.updateUI(with: categories ?? [])
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.categoriesView.displayError(error,
                                                      title: "Failed to Fetch Categories")
                    }
                }
                DispatchQueue.main.async {
                    self?.categoriesView.stopIndicator()
                }
            }
        }
    
    
    
    
}
