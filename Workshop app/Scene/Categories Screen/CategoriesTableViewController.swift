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
    func updateUI()
    func displayError(_ error: Error, title: String)
}

class CategoriesTableViewController: UITableViewController {
    
    lazy var categoriesPresenter: CategoriesPresenterProtocol = CategoriesPresenter(view: self, networkService: MenuController.shared)
    var indicator = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initIndicator()
        startIndicator()
        
        categoriesPresenter.fetchCategoriesFromNetwork()
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoriesPresenter.getCategoriesCount()
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categoriesPresenter.getCategory(at: indexPath.row).capitalized
        
        // Configure the cell...
        
        return cell
    }
    
    func initIndicator() {
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
                   let destVC = segue.destination as! MenuTableViewController
            let menuPresenter = MenuPresenter (view: destVC, category: categoriesPresenter.getCategory(at: indexPath.row))
            destVC.menuPresenter = menuPresenter
        }
    }
    
       
}

extension CategoriesTableViewController: CategoriesViewProtocol {
    
    func startIndicator() {
        indicator.startAnimating()
    }
    func stopIndicator() {
        indicator.stopAnimating()
    }
    func updateUI() {
        
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
