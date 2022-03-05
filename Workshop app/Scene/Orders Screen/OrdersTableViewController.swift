//
//  OrdersTableViewController.swift
//  Workshop app
//
//  Created by Mohamed Ahmed on 25/02/2022.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit
protocol OrdersTableViewControllerProtocol: class{
     func setMinutesToPrepareOrder(minutes:Int)
     func displayEstimatedTime(minutesToPrepare : Int)
    func displayError(_ error: String, title: String)
}
class OrdersTableViewController: UITableViewController,OrdersTableViewControllerProtocol {
    
    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBOutlet weak var submitBtn: UIBarButtonItem!
    var minutesToPrepareOrder = 0
    var ordersPresenter:OrdersPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersPresenter = OrdersPresenter(view: self, networkService: MenuController.shared)
        notify()

    }
    
    func notify() {
        NotificationCenter.default.addObserver(tableView!,
        selector: #selector(tableView.reloadData),
        name: ordersPresenter?.getNotifyName(), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isListEmpty()
        
    }
    func isListEmpty(){
        if (ordersPresenter?.getMenuItemsCount() == 0){
            submitBtn.isEnabled=false
            
        }
        else{
            submitBtn.isEnabled=true
        }
    }
    @IBAction func SubmitPressed(_ sender: Any) {
        
        let orderTotal = ordersPresenter?.getOrderTotal()
            let formattedTotal = "$ \(orderTotal!)"
            let alertController = UIAlertController(title:
               "Confirm Order", message: "You are about to submit your order with a total of \(formattedTotal)",
               preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Submit",
               style: .default, handler: { _ in
                self.ordersPresenter?.uploadOrder(menuIds: [])
            }))
            alertController.addAction(UIAlertAction(title: "Cancel",
               style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        
    }
    
    func setMinutesToPrepareOrder(minutes:Int) {
        self.minutesToPrepareOrder = minutes
    }
    func displayEstimatedTime(minutesToPrepare : Int){
        let alert = UIAlertController(title: "Order Confirmed", message:
              "Thank you for your Order\nYour Estimated Time is \(minutesToPrepare) minutes", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .default, handler: { _ in
               self.ordersPresenter.remveAll()
                                            
                self.isListEmpty()
             }
                                         ))
        present(alert, animated: true, completion: nil)
        }
    
    func displayError(_ error: String, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message:
               error, preferredStyle: .alert)
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
        return (ordersPresenter?.getMenuItemsCount()) ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier:
               "Order", for: indexPath)
            configure(cell, forItemAt: indexPath)

        return cell
    }
    func configure(_ cell: UITableViewCell, forItemAt indexPath:
       IndexPath) {
        let menuItems = ordersPresenter.getMenuItems()
        print("****************\(indexPath.row)")
        let menuItem =  menuItems[indexPath.row]
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
extension OrdersTableViewController{
    func reloadTableView() {
        self.tableView.reloadData()
    }
}
