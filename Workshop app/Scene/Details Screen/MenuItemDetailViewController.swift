//
//  DetailsViewController.swift
//  Workshop app
//
//  Created by Youssef on 2/25/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit

protocol DetailsViewProtocol {
    func updateUI()
    
}

class MenuItemDetailViewController: UIViewController {

    @IBOutlet weak var addToOrderButton: UIButton!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var detailsPresenter: DetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0,
           usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
           options: [], animations: {
            self.addToOrderButton.transform =
               CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.addToOrderButton.transform =
               CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        detailsPresenter?.addItemToOrder()
    }
}

extension MenuItemDetailViewController: DetailsViewProtocol {
    func updateUI() {
        nameLabel.text = detailsPresenter?.menuItem!.name
            priceLabel.text = "$\(detailsPresenter!.menuItem!.price)"
            detailTextLabel.text = detailsPresenter?.menuItem!.itemDescription
            addToOrderButton.layer.cornerRadius = 20.0
        print(MenuController.shared.images[detailsPresenter!.menuItem!.id - 1])
        imageView.image =  UIImage(named: MenuController.shared.images[detailsPresenter!.menuItem!.id - 1])
    }
}
