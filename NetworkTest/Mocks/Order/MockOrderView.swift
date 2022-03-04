//
//  MockOrderView.swift
//  NetworkTest
//
//  Created by esraa on 3/5/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation
class MockOrderView{
    var isTableReloaded = false
    
    func reloadTableView() {
        isTableReloaded = true
    }
}
