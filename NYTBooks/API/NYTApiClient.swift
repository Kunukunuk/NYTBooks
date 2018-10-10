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
    static let baseListNameURL = "https://api.nytimes.com/svc/books/v3/lists/names.json"
    static let baseBestSellerURL = "https://api.nytimes.com/svc/books/v3/lists.json?"
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func getBooks(completion: @escaping ([Books]?, Error?) -> ()) {
        
        let url = URL(string: NYTApiClient.baseListNameURL + "?api-key=\(NYTApiClient.apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let bookDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                let movies = Books.books(dictionaries: bookDictionaries)
                completion(movies, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func getBestSellerBooks(categoryName: String, completion: @escaping ([Books]?, Error?) -> ()) {
        
        Alamofire.request(NYTApiClient.baseBestSellerURL + "api-key=\(NYTApiClient.apiKey)&list=\(categoryName)").responseJSON {
            reponse in
            if reponse.result.isSuccess {
                let bestseller : JSON = JSON(reponse.result.value!)
                print(bestseller)
                //self.updateWeatherData(json: weatherData)
            } else {
                //self.cityLabel.text = "Connection Issues"
            }
        }
    }
}
