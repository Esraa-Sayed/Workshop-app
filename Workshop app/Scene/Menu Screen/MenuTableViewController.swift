//
//  MenuTableViewController.swift
//  Workshop app
//
//  Created by Mohamed Ahmed on 25/02/2022.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit
import Kingfisher

protocol MenuViewProtocol {
    func startIndicator()
    func stopIndicator()
    func updateUI(with menuItems: [MenuItem])
    func displayError(_ error: Error, title: String)
}

class MenuTableViewController: UITableViewController {
    
    
    var indicator = UIActivityIndicatorView(style: .large)
    var menuPresenter: MenuPresenterProtocol!
    
    init?(coder: NSCoder, category: String) {
        //menuPresenter.category = category
        super.init(coder: coder)
        menuPresenter = MenuPresenter(view: self, category: category)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initIndicator()
        startIndicator()
        
        menuPresenter.fetchMenuItems()
        
        
    }
    
    
    
    func initIndicator() {
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuPresenter.menuItems?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        //var imageURL = menuPresenter.menuItems?[indexPath.row].imageURL
//        let index = imageURL?.index(imageURL?.endIndex!, offsetBy: -4)
//        imageURL = String(imageURL[..<index])
//        print(imageURL)
        cell.textLabel?.text = menuPresenter.menuItems?[indexPath.row].name
        cell.detailTextLabel?.text = "$ \(String(format: "%.1f", menuPresenter.menuItems?[indexPath.row].price as! CVarArg))"

        cell.imageView?.image = UIImage(named: MenuController.shared.images[(menuPresenter!.menuItems?[indexPath.row].id)! - 1])
    
    
        //cell.imageView?.kf.setImage(with: URL(string: imageURL))
        return cell
    }
    
    
    @IBSegueAction func showMenuItem(_ coder: NSCoder, sender: Any?) -> MenuItemDetailViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath =
            tableView.indexPath(for: cell) else {
                return nil
        }
        
        let menuItem = menuPresenter.menuItems?[indexPath.row]
        return MenuItemDetailViewController(coder: coder, menuItem:menuItem!)
        
    }
}

extension MenuTableViewController: MenuViewProtocol {
    func startIndicator() {
        indicator.startAnimating()
    }
    func stopIndicator() {
        indicator.stopAnimating()
    }
    func updateUI(with menuItems: [MenuItem]) {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.title = self.menuPresenter.category?.capitalized
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
}
