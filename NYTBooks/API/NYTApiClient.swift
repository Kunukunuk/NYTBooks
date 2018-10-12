//
//  NYTApiClient.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/9/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class NYTApiClient {
    
    static let apiKey = "41b8a4e7f29d4d76908fb3c22c5dd074"
    static let baseListNameURL = "https://api.nytimes.com/svc/books/v3/lists/names.json?"
    static let baseBestSellerURL = "https://api.nytimes.com/svc/books/v3/lists.json?"
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    //Mark: Get category names from NYT API
    func getCategory(completion: @escaping (Error?) -> ()) {
        
        let url = URL(string: NYTApiClient.baseListNameURL + "api-key=\(NYTApiClient.apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let bookDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                _ = Category.saveCategory(dictionaries: bookDictionaries)
                completion(nil)
            } else {
                completion(error)
            }
        }
        task.resume()
    }
    //Mark: Get best seller books from NYT API
    func getBestSellerBooks(category: Category, categoryName: String, completion: @escaping (Error?) -> ()) {
        
        Alamofire.request(NYTApiClient.baseBestSellerURL + "api-key=\(NYTApiClient.apiKey)&list=\(categoryName)").responseJSON {
            reponse in
            if reponse.result.isSuccess {
                let bestSeller : JSON = JSON(reponse.result.value!)
                
                _ = BestSellerBooks.books(category: category,dictionaries: bestSeller)
                completion(nil)
            } else {
                completion( reponse.result.error)
            }
        }
    }
    
}
