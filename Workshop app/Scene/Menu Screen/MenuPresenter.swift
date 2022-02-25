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
    
    init(view: MenuViewProtocol, category: String) {
        self.menuView = view
        self.category = category
    }
    
    func fetchMenuItems() {
        MenuController.shared.fetchMenuItems(forCategory: category ?? "")
        { [weak self] (result) in
            switch result {
            case .success(let menuItems):
                self?.menuItems = menuItems
                DispatchQueue.main.async {
                    self?.menuView!.updateUI(with: menuItems ?? [])
                }
            case .failure(let error):
                self?.menuView!.displayError(error, title: "Failed to Fetch Menu Items for \(self?.category)")
            }
            
            DispatchQueue.main.async {
                self?.menuView!.stopIndicator()
            }
        }
    }
}
