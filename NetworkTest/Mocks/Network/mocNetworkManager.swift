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
    
    func fetchCategories(completion: @escaping (Result<[String]?, Error>) -> Void) {
    }
    
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping (Result<[MenuItem]?, Error>) -> Void) {
    }
    
    func submitOrder<T>(forMenuIDs menuIDs: [Int], completion: @escaping (Result<T, Error>) -> Void) where T : Decodable  {
        guard let data = data(in: fileName, extension: "json") else {
                   assertionFailure("Unable to find the file with name: \(fileName ?? "")")
                   return
               }
               
               do {
                   let apiResponse = try JSONDecoder().decode(T.self, from: data)
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
    
   /* func request<T>(fromEndpoint: EndPoint, httpMethod: HttpMethod, param: [String : Any]?, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let data = data(in: fileName, extension: "json") else {
            assertionFailure("Unable to find the file with name: \(fileName ?? "")")
            return
        }
        
        do {
            let apiResponse = try JSONDecoder().decode(T.self, from: data)
            completion(.success(apiResponse))
        } catch {
            completion(.failure(OrderAppError.decodingError))
            print(error.localizedDescription)
        }

    }*/
    
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
