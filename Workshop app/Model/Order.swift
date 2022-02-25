//
//  OrderModel.swift
//  Workshop app
//
//  Created by Mohamed Ahmed on 25/02/2022.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation
struct Order: Codable {
    var menuItems: [MenuItem]

    init(menuItems :[MenuItem] = []){
        self.menuItems = menuItems
    }
}
