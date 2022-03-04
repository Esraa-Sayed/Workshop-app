//
//  MenuItemDetailsPresenter.swift
//  Workshop app
//
//  Created by Youssef on 2/25/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation

protocol DetailsPresenterProtocol {
    var menuItem: MenuItem? {get set}
    func addItemToOrder() -> MenuItem
}

class MenuDetailsPresenter: DetailsPresenterProtocol {

    var menuItem: MenuItem?
    var detailsView: DetailsViewProtocol
    var networkService: NetworkService!
        
    init(view: DetailsViewProtocol, menuItem: MenuItem, networkService: NetworkService = MenuController.shared) {
        detailsView = view
        self.menuItem = menuItem
        self.networkService = networkService
    }
    
    func addItemToOrder() -> MenuItem{
        networkService.order.menuItems.append(menuItem!)
        return networkService.order.menuItems.last!
    }
}
