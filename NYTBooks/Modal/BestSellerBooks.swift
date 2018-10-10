//
//  BestSellerBooks.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/9/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import Foundation
import SwiftyJSON

class BestSellerBooks {
    
    var displayName: String
    var rankLastWeek: Int
    var pubDate: String
    var amazonURL: String
    var rank: Int
    var weekOnList: Int
    var bestSellerDate: String
    var reviews: JSON
    var bookDetails: JSON
    
    init(bestSeller: JSON) {
        
        displayName = bestSeller["display_name"].stringValue
        rankLastWeek = bestSeller["rank_last_week"].intValue
        pubDate = bestSeller["published_date"].stringValue
        amazonURL = bestSeller["amazon_product_url"].stringValue
        rank = bestSeller["rank"].intValue
        weekOnList = bestSeller["week_on_list"].intValue
        bestSellerDate = bestSeller["bestsellers_date"].stringValue
        reviews = bestSeller["reviews"]
        bookDetails = bestSeller["book_details"]
        
    }
    
    class func books(dictionaries: JSON) -> [BestSellerBooks] {
        var books: [BestSellerBooks] = []
        
        let dictionaryResult = dictionaries["results"]
        for (_, dictionary )in dictionaryResult {
            let book = BestSellerBooks(bestSeller: dictionary)
            books.append(book)
        }
        
        return books
    }
    
}
