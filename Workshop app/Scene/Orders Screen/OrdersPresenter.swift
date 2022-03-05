//
//  OrdersPresenter.swift
//  Workshop app
//
//  Created by Youssef on 2/25/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation
protocol OrdersPresenterProtocol {
     func getNotifyName()->Notification.Name
     func getMenuItemsCount()->Int
     func getOrderTotal()->Double
     func uploadOrder(menuIds:[Int])
     func getMenuItems()->[MenuItem]
    func remveAll()
}
class OrdersPresenter:OrdersPresenterProtocol {
   var orderView: OrdersTableViewControllerProtocol!
    
    var networkService: NetworkService!
    var minutesToPrepare:Int!
    private let orderTotal:Double?
    private var notify:Notification.Name?
    private var mapMenu:[Int]
    var ids:[Int] = []
    init(view: OrdersTableViewControllerProtocol, networkService: NetworkService = MenuController()) {
        orderView = view
        self.networkService = networkService
        orderTotal = self.networkService.order.menuItems.reduce(0.0){ (result, menuItem) -> Double in
            return result + menuItem.price
        }
        notify = MenuController.orderUpdatedNotification
        mapMenu = self.networkService.order.menuItems.map{ $0.id }
        ids = networkService.order.menuItems.map
        { $0.id }
    }
    func getNotifyName()->Notification.Name
    {
        return notify!
    }
    func getMenuItemsCount()->Int{
        return networkService.order.menuItems.count
    }
    func getOrderTotal()->Double{
        return orderTotal!
    }
    func uploadOrder( menuIds: [Int] = []){
        
        if(menuIds != [])
        {
            ids = menuIds
        }
        networkService.submitOrder(forMenuIDs: ids)
           { (result) in
            switch result {
            case .success(let minutesToPrepare):
                self.minutesToPrepare = minutesToPrepare
                DispatchQueue.main.async {
                   
                    self.orderView.setMinutesToPrepareOrder(minutes: minutesToPrepare)
                   self.orderView.displayEstimatedTime(minutesToPrepare: minutesToPrepare)
                }
            case .failure(let _):
                self.orderView.displayError("error", title: "Order Submission Failed")
            }
        }
    }
    func getMenuItems()->[MenuItem]
    {
        var menuItem:[MenuItem] = MenuController.shared.order.menuItems
        return menuItem
    }
    func remveAll()
    {
         MenuController.shared.order.menuItems.removeAll()
    }
}

