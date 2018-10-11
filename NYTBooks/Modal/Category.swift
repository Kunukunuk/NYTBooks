//
//  Category.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/10/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var listName: String = ""
    @objc dynamic var displayName: String = ""
    //var updated: String
    //var newestPubDate: String
    //var oldestPubdate: String
    @objc dynamic var listNameEncoded: String = ""
    let bestSellerBook = List<BestSellerBooks>()
    
    /*init(dictionary: [String: Any]) {
        
        listName = dictionary["list_name"] as? String ?? "No title"
        displayName = dictionary["display_name"] as? String ?? "No display name"
        //updated = dictionary["updated"] as? String ?? "No updates"
        //newestPubDate = dictionary["newest_published_date"] as? String ?? "No new date"
        //oldestPubdate = dictionary["oldest_published_date"] as? String ?? "No old date"
        listNameEncoded = dictionary["list_name_encoded"] as? String ?? "No name encoded"
        
    }*/
    
    class func saveCategory(dictionaries: [[String: Any]]){
        let realm = try! Realm()
        
        for categoryDictionary in dictionaries {
            
            let category = Category()
            category.listName = categoryDictionary["list_name"] as? String ?? "No title"
            category.displayName = categoryDictionary["display_name"] as? String ?? "No display name"
            category.listNameEncoded = categoryDictionary["list_name_encoded"] as? String ?? "No name encoded"
            
            do {
                try realm.write {
                    realm.add(category)
                }
            } catch {
                print("error saving to realm. Error: \(error) and \(error.localizedDescription)")
            }
            
        }
        
    }
}
