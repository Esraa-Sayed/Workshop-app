//
//  MenuTableViewController.swift
//  Workshop app
//
//  Created by Mohamed Ahmed on 25/02/2022.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit
import Kingfisher

class MenuTableViewController: UITableViewController {
    
    let category: String
    var menuItems = [MenuItem]()
    init?(coder: NSCoder, category: String) {
        self.category = category
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MenuController.shared.fetchMenuItems(forCategory: category)
        { (result) in
            switch result {
            case .success(let menuItems):
                self.updateUI(with: menuItems ?? [])
            case .failure(let error):
                self.displayError(error, title: "Failed to Fetch Menu Items for \(self.category)")
            }
        }
    }
    
    func updateUI(with menuItems: [MenuItem]) {
        self.menuItems = menuItems
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.title = self.category.capitalized
        }
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message:
                error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style:
                .default, handler: nil))
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
        return menuItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        var imageURL = menuItems[indexPath.row].imageURL
        let index = imageURL.index(imageURL.endIndex, offsetBy: -4)
        imageURL = String(imageURL[..<index])
        print(imageURL)
        cell.textLabel?.text = menuItems[indexPath.row].name
        cell.detailTextLabel?.text = "$ \(String(menuItems[indexPath.row].price))"
        //cell.imageView?.kf.setImage(with: URL(string: imageURL))
        return cell
    }
    
    
    @IBSegueAction func showMenuItem(_ coder: NSCoder, sender: Any?) -> MenuItemDetailViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath =
            tableView.indexPath(for: cell) else {
                return nil
        }
        
        let menuItem = menuItems[indexPath.row]
        return MenuItemDetailViewController(coder: coder, menuItem:
            menuItem)
        
    }
}
