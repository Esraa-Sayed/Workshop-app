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
    func uploadOrder()
}
class OrdersPresenter:OrdersPresenterProtocol {
    private weak var orderView: OrdersTableViewControllerProtocol!
    private let orderTotal:Double =
       MenuController.shared.order.menuItems.reduce(0.0)
       { (result, menuItem) -> Double in
        return result + menuItem.price
    }
    private var notify:Notification.Name = MenuController.orderUpdatedNotification
    private var mapMenu:[Int] = MenuController.shared.order.menuItems.map
    { $0.id }
    init(view: OrdersTableViewControllerProtocol) {
        orderView = view
    }
    func getNotifyName()->Notification.Name
    {
        return notify
    }
    func getMenuItemsCount()->Int{
        return MenuController.shared.order.menuItems.count
    }
    func getOrderTotal()->Double{
        return orderTotal
    }
    func uploadOrder() {
        let menuIds = MenuController.shared.order.menuItems.map
        { $0.id }
        MenuController.shared.submitOrder(forMenuIDs: menuIds)
           { (result) in
            switch result {
            case .success(let minutesToPrepare):
                DispatchQueue.main.async {
                    self.orderView.setMinutesToPrepareOrder(minutes: minutesToPrepare)
                   self.orderView.displayEstimatedTime(minutesToPrepare: minutesToPrepare)
                }
            case .failure(let error):
                self.orderView.displayError(error, title: "Order Submission Failed")
            }
        }
    }
    
    
}
/*

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

 */
