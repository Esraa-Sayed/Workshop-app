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
    func addItemToOrder()
}

class MenuDetailsPresenter: DetailsPresenterProtocol {

    var menuItem: MenuItem?
    var detailsView: DetailsViewProtocol
        
    init(view: DetailsViewProtocol, menuItem: MenuItem) {
        detailsView = view
        self.menuItem = menuItem
    }
    
    func addItemToOrder() {
        MenuController.shared.order.menuItems.append(menuItem!)
    }
}
