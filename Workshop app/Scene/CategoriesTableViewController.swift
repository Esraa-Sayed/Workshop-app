//
//  CategoriesTableViewController.swift
//  Workshop app
//
//  Created by Mohamed Ahmed on 25/02/2022.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    var indicator : UIActivityIndicatorView?
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        self.view.addSubview(indicator!)
        indicator?.startAnimating()
        
        MenuController.shared.fetchCategories { [weak self] (result)  in
            switch result {
            case .success(let categories):
                self?.updateUI(with: categories ?? [])
            case .failure(let error):
                self?.displayError(error,
                                  title: "Failed to Fetch Categories")
            }
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating()
                
            }
        }
    }
    
    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
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
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].capitalized
        // Configure the cell...
        
        return cell
    }
    
    @IBSegueAction func showMenu(_ coder: NSCoder, sender: Any?) -> MenuTableViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath =
               tableView.indexPath(for: cell) else {
                return nil
            }
         
            let category = categories[indexPath.row]
            return MenuTableViewController(coder: coder, category:
               category)
    }
}
