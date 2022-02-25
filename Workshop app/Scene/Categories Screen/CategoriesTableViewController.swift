//
//  CategoriesTableViewController.swift
//  Workshop app
//
//  Created by Mohamed Ahmed on 25/02/2022.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit

protocol CategoriesViewProtocol: class {
    func startIndicator()
    func stopIndicator()
    func updateUI(with categories: [String])
    func displayError(_ error: Error, title: String)
}

class CategoriesTableViewController: UITableViewController {
    
    var categoriesPresenter: CategoriesPresenterProtocol!
    var indicator = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initIndicator()
        startIndicator()
        categoriesPresenter = CategoriesPresenter(view: self)
        
        categoriesPresenter.fetchCategoriesFromNetwork()
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(categoriesPresenter.categories != nil) {
            return categoriesPresenter.categories.count
        }
        else{
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categoriesPresenter.categories[indexPath.row].capitalized
        // Configure the cell...
        
        return cell
    }
    
    func initIndicator() {
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    
    
    @IBSegueAction func showMenu(_ coder: NSCoder, sender: Any?) -> MenuTableViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath =
               tableView.indexPath(for: cell) else {
                return nil
            }
        
            let category = categoriesPresenter.categories[indexPath.row]
            return MenuTableViewController(coder: coder, category:
               category)
    }
}

extension CategoriesTableViewController: CategoriesViewProtocol {
    func startIndicator() {
        indicator.startAnimating()
    }
    func stopIndicator() {
        indicator.stopAnimating()
    }
    func updateUI(with categories: [String]) {
        
        self.tableView.reloadData()
    }
    func displayError(_ error: Error, title: String) {
        
        let alert = UIAlertController(title: title,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}
