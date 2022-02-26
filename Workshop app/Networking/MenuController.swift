//
//  NetworkHelper.swift
//  Workshop app
//
//  Created by Mohamed Ahmed on 25/02/2022.
//  Copyright © 2022 esraa. All rights reserved.
//

import Foundation

protocol NetworkService {
    
    typealias MinutesToPrepare = Int
    var order: Order {get set}
    static var orderUpdatedNotification: Notification.Name{get}
    
    func fetchCategories(completion: @escaping (Result<[String]?,Error>) -> Void)
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping (Result<[MenuItem]?,Error>) -> Void)
    func submitOrder(forMenuIDs menuIDs: [Int], completion: @escaping (Result<MinutesToPrepare, Error>) -> Void)
    
}

class MenuController: NetworkService{
    
    let baseURL = URL(string: "http://localhost:8080/")!
    static let shared = MenuController()
    let images = ["1.jpeg","2.jpeg","3.jpeg","4.jpeg","5.jpeg","6.jpeg"]
    static let orderUpdatedNotification =
    Notification.Name("MenuController.orderUpdated")
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name:
               MenuController.orderUpdatedNotification, object: nil)
        }
    }
    
    

    func fetchCategories(completion: @escaping (Result<[String]?,Error>) -> Void) {
        let categoriesURL =
        baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoriesURL)
        { (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let categoriesResponse = try
                    jsonDecoder.decode(CategoriesResponse.self,
                                       from: data)
                    completion(.success(categoriesResponse.categories))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    
    
    func fetchMenuItems(forCategory categoryName: String,
                        completion: @escaping (Result<[MenuItem]?,Error>) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL,
                                       resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category",
                                              value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL)
        { (data, response, error) in
            if let data = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let menuResponse = try
                           jsonDecoder.decode(MenuResponse.self, from: data)
                        completion(.success(menuResponse.items))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
           
        }
        task.resume()
    }
    
    
    
    func submitOrder(forMenuIDs menuIDs: [Int], completion:
                     @escaping (Result<MinutesToPrepare, Error>) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        let data = ["menuIds": menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let orderResponse = try
                       jsonDecoder.decode(OrderResponse.self, from: data)
                    completion(.success(orderResponse.preparationTime))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
