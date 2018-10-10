//
//  Books.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/9/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import Foundation

class Books {
    var listName: String
    var displayName: String
    var updated: String
    var newestPubDate: String
    var oldestPubdate: String
    var listNameEncoded: String
    
    init(dictionary: [String: Any]) {
        listName = dictionary["list_name"] as? String ?? "No title"
        displayName = dictionary["display_name"] as? String ?? "No display name"
        updated = dictionary["updated"] as? String ?? "No updates"
        newestPubDate = dictionary["newest_published_date"] as? String ?? "No new date"
        oldestPubdate = dictionary["oldest_published_date"] as? String ?? "No old date"
        listNameEncoded = dictionary["list_name_encoded"] as? String ?? "No name encoded"
        
    }
    
    class func books(dictionaries: [[String: Any]]) -> [Books] {
        var books: [Books] = []
        for dictionary in dictionaries {
            let book = Books(dictionary: dictionary)
            books.append(book)
        }
        
        return books
    }
}
