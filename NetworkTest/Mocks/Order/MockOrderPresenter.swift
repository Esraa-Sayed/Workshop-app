//
//  MockOrderPresenter.swift
//  NetworkTest
//
//  Created by esraa on 3/5/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation
@testable import Workshop_app
class MockOrderPresenter: OrdersPresenterProtocol
{
    var M:[MenuItem]?
    func getMenuItems() -> [MenuItem] {
        var x:MenuItem = MenuItem(category: "salads", id: 6, imageURL: "http://localhost:8080/images/6.png", name: "Italian Salad", itemDescription: "Garlic, red onions, tomatoes, mushrooms, and olives on top of romaine lettuce.", price: 5)
        var M: [MenuItem] = [x,x,x,x,x,x,x]
        return M
    }
    
       var networkService: NetworkService = MockNetworkManager(fileName: "")
       var minutesToPrepare:Int!
      private let orderTotal:Double? = nil
       private var notify:Notification.Name?
    func getNotifyName() -> Notification.Name {
        return Notification.Name("MenuController.orderUpdated")
    }
    
    func getMenuItemsCount() -> Int {
        return 5
    }
    
    func getOrderTotal() -> Double {
        return 3.4
    }
    
    func uploadOrder(menuIds: [Int]) {
        minutesToPrepare = 5
    }
    func remveAll()
    {
        M = nil
    }
    
}

