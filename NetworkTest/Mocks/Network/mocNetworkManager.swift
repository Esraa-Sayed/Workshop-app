//
//  mocNetworkManager.swift
//  NetworkTest
//
//  Created by esraa on 3/4/22.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation

@testable import Workshop_app

class MockNetworkManager: NetworkService {
    
    static var orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name:
               MenuController.orderUpdatedNotification, object: nil)
        }
    }
    
    func fetchCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> Void) {
        guard let data = data(in: fileName, extension: "json") else {
            assertionFailure("Unable to find the file with name: Menu")
            return
        }
        do {
            let apiResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
            completion(.success(apiResponse))
        } catch {
            completion(.failure(WorkshopAppError.decodingError))
            print(error.localizedDescription)
        }
    }
    
    
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping (Result<[MenuItem]?, Error>) -> Void) {
        
        guard let data = data(in: fileName, extension: "json") else {
                   assertionFailure("Unable to find the file with name: Menu")
                   return
               }
               do {
                   let apiResponse = try JSONDecoder().decode(MenuResponse.self, from: data)
                   completion(.success(apiResponse.items))
               } catch {
                   completion(.failure(WorkshopAppError.decodingError))
                   print(error.localizedDescription)
               }
    }
    
    func submitOrder(forMenuIDs menuIDs: [Int], completion: @escaping (Result<MinutesToPrepare, Error>) -> Void) {
        guard let data = data(in: fileName, extension: "json") else {
                   assertionFailure("Unable to find the file with name: \(fileName ?? "")")
                   return
               }
               
               do {
                let apiResponse = try JSONDecoder().decode(MinutesToPrepare.self, from: data)
                   completion(.success(apiResponse))
               } catch {
                   completion(.failure(WorkshopAppError.decodingError))
                   print(error.localizedDescription)
               }
    }
    
    var baseURL: String = ""
    // MARK: - Properties
    
    var fileName: String?
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    // MARK: - Handlers
    /// Data in file
    /// - Parameters:
    ///   - fileName: File name
    ///   - extension: File extensio
    /// - Returns: Optional data
    func data(in fileName: String?, extension: String?) -> Data? {
        guard let path = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: `extension`) else {
            assertionFailure("Unable to find file name \(String(describing: fileName))")
            return nil
        }
        
        guard let data = try? Data(contentsOf: path) else {
            assertionFailure("Unable to parse data")
            return nil
        }
        
        return data
    }
    
    enum WorkshopAppError: Error {
        case decodingError
    }
}
