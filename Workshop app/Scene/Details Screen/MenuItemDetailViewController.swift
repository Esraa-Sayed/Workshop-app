//
//  DetailsViewController.swift
//  Workshop app
//
//  Created by Youssef on 2/25/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {

    @IBOutlet weak var addToOrderButton: UIButton!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    let menuItem: MenuItem
    
    init?(coder: NSCoder, menuItem: MenuItem) {
        self.menuItem = menuItem
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(menuItem)
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        nameLabel.text = menuItem.name
        priceLabel.text = "$\(menuItem.price )"
        detailTextLabel.text = menuItem.itemDescription
        addToOrderButton.layer.cornerRadius = 20.0
        
        var imageURL = menuItem.imageURL
    
        let index = imageURL.index(imageURL.endIndex, offsetBy: -4)
        imageURL = String(imageURL[..<index])
        print(imageURL)
        let url = URL(string: String(imageURL))
        fetchImage(url: url!)
               { (image) in
                guard let image = image else { return }
                   self.imageView.image = image
            }
        
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
        MenuController.shared.order.menuItems.append(menuItem)
    }
     
    func fetchImage(url: URL, completion: @escaping (UIImage?)
       -> Void) {
        let task = URLSession.shared.dataTask(with: url)
           { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
