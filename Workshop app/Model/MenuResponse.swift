//
//  MenuModel.swift
//  Workshop app
//
//  Created by Mohamed Ahmed on 25/02/2022.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation

struct MenuResponse: Codable ,Equatable {
    var items: [MenuItem]
}

// MARK: - Item
struct MenuItem: Codable , Equatable{
    var category: String
    var id: Int
    var imageURL: String
    var name, itemDescription: String
    var price: Double

    enum CodingKeys: String, CodingKey {
        case category, id
        case imageURL = "image_url"
        case name
        case itemDescription = "description"
        case price
    }
    init(category: String,id: Int,imageURL: String,name:String, itemDescription: String,price: Double) {
        self.category  = category
        self.id = id
         self.imageURL = imageURL
        self.name = name
         self.itemDescription = itemDescription
         self.price =  price
    }
}
