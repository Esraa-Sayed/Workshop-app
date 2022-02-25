//
//  OrderSubmitResponse.swift
//  Workshop app
//
//  Created by Mohamed Ahmed on 25/02/2022.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation
struct OrderResponse: Codable {
    let preparationTime: Int

    enum CodingKeys: String, CodingKey {
        case preparationTime = "preparation_time"
    }
}
