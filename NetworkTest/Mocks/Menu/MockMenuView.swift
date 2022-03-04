//
//  MockMenuView.swift
//  NetworkTest
//
//  Created by Mohamed Ahmed on 04/03/2022.
//  Copyright © 2022 esraa. All rights reserved.
//
import XCTest
@testable import Workshop_app

class MockMenuView: MenuViewProtocol {
    
    var isUIUpdated = false
    var isIndicatorStarted = false
    
    func startIndicator() {
        isIndicatorStarted = true
    }
    
    func stopIndicator() {
        isIndicatorStarted = false
    }
    
    func updateUI(with menuItems: [MenuItem]) {
        isUIUpdated = true
    }
    
    func displayError(_ error: String, title: String) {
        print("\(title) : \(error)")
    }
    
   
}
