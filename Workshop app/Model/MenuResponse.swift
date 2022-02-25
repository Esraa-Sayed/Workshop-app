//
//  MenuModel.swift
//  Workshop app
//
//  Created by Mohamed Ahmed on 25/02/2022.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation

struct MenuResponse: Codable {
    let items: [MenuItem]
}

// MARK: - Item
struct MenuItem: Codable {
    let category: String
    let id: Int
    let imageURL: String
    let name, itemDescription: String
    let price: Double

    enum CodingKeys: String, CodingKey {
        case category, id
        case imageURL = "image_url"
        case name
        case itemDescription = "description"
        case price
    }
}
