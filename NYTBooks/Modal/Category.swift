//
//  Category.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/10/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import Foundation

class Category {
    
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
    
    class func categoryDict(dictionaries: [[String: Any]]) -> [Category] {
        var categoryArray: [Category] = []
        for categoryDictionary in dictionaries {
            let category = Category(dictionary: categoryDictionary)
            categoryArray.append(category)
        }
        
        return categoryArray
    }
}
