//
//  MenuPresenter.swift
//  Workshop app
//
//  Created by Youssef on 2/25/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation

protocol MenuPresenterProtocol {
    var category: String? {get set}
    var menuItems: [MenuItem]? {get set}
    func fetchMenuItems()
}

class MenuPresenter: MenuPresenterProtocol {
    
    var menuItems: [MenuItem]?
    var category: String?
    var menuView: MenuViewProtocol?
    let networkService: NetworkService!
    
    init(view: MenuViewProtocol, category: String, networkService: NetworkService = MenuController.shared) {
        self.menuView = view
        self.category = category
        self.networkService = networkService
    }
    
    func fetchMenuItems() {
        networkService.fetchMenuItems(forCategory: category ?? "")
        { [weak self] (result) in
            switch result {
            case .success(let menuItems):
                self?.menuItems = menuItems
                print(menuItems)
                DispatchQueue.main.async {
                    self?.menuView!.updateUI(with: menuItems ?? [])
                }
            case .failure(let error):
                self?.menuView!.displayError(error.localizedDescription, title: "Failed to Fetch Menu Items for \(self?.category)")
            }
            
            DispatchQueue.main.async {
                self?.menuView!.stopIndicator()
            }
        }
    }
}
