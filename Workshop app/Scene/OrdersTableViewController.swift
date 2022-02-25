//
//  OrdersTableViewController.swift
//  Workshop app
//
//  Created by Mohamed Ahmed on 25/02/2022.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    @IBOutlet weak var submitBtn: UIBarButtonItem!
    var minutesToPrepareOrder = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       NotificationCenter.default.addObserver(tableView!,
              selector: #selector(UITableView.reloadData),
              name: MenuController.orderUpdatedNotification, object: nil)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isListEmpty()
        
    }
    func isListEmpty(){
        if (MenuController.shared.order.menuItems.count == 0){
            submitBtn.isEnabled=false
            
        }
        else{
            submitBtn.isEnabled=true
        }
    }
    @IBAction func SubmitPressed(_ sender: Any) {
        
        let orderTotal =
               MenuController.shared.order.menuItems.reduce(0.0)
               { (result, menuItem) -> Double in
                return result + menuItem.price
            }
            let formattedTotal = "$ \(String(orderTotal))"
            let alertController = UIAlertController(title:
               "Confirm Order", message: "You are about to submit your order with a total of \(formattedTotal)",
               preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Submit",
               style: .default, handler: { _ in
                self.uploadOrder()
            }))
            alertController.addAction(UIAlertAction(title: "Cancel",
               style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        
    }
    
    func uploadOrder() {
        let menuIds = MenuController.shared.order.menuItems.map
           { $0.id }
        MenuController.shared.submitOrder(forMenuIDs: menuIds)
           { (result) in
            switch result {
            case .success(let minutesToPrepare):
                DispatchQueue.main.async {
                    self.minutesToPrepareOrder = minutesToPrepare
                    self.displayEstimatedTime(minutesToPrepare : minutesToPrepare)
                }
            case .failure(let error):
                self.displayError(error, title: "Order Submission Failed")
            }
        }
    }
    func displayEstimatedTime(minutesToPrepare : Int){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Order Confirmed", message:
              "Thank you for your Order\nYour Estimated Time is \(minutesToPrepare) minutes", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .default, handler: { _ in
                MenuController.shared.order.menuItems.removeAll()
                self.isListEmpty()
             }
                                         ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message:
               error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
               style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MenuController.shared.order.menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier:
               "Order", for: indexPath)
            configure(cell, forItemAt: indexPath)

        return cell
    }
    func configure(_ cell: UITableViewCell, forItemAt indexPath:
       IndexPath) {
        let menuItem = MenuController.shared.order.menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = "$\(menuItem.price)"
        
    }
    override func tableView(_ tableView: UITableView,
       canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView,
       commit editingStyle: UITableViewCell.EditingStyle,
       forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MenuController.shared.order.menuItems.remove(at:
               indexPath.row)
            isListEmpty()
        }
    }
}
