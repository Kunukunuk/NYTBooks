//
//  BestSellerBooks.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/9/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class BestSellerBooks: Object{
    
    //var displayName: String
    //var rankLastWeek: Int = 0
    //var pubDate: String
    @objc dynamic var amazonURL: String = ""
    @objc dynamic var rank: Int = 0
    @objc dynamic var weekOnList: Int = 0
    //var bestSellerDate: String
//    var reviews: JSON = ""
//    var bookDetails: JSON = ""
    
    @objc dynamic var bookTitle: String = ""
    //var bookContributor: String?
    @objc dynamic var bookDescription: String = ""
    @objc dynamic var bookAuthor: String = ""
    //var bookPrimaryISBN10: String?
    //var bookPrimaryISBN13: String?
    //var bookPublisher: String?
    
    @objc dynamic var sundayReview: String = ""
    @objc dynamic var firstChapter: String = ""
    @objc dynamic var articleChapter: String = ""
    @objc dynamic var bookReview: String  = ""
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "bestSellerBook")
    
    /*init(bestSeller: JSON) {
        
        displayName = bestSeller["display_name"].stringValue
        rankLastWeek = bestSeller["rank_last_week"].intValue
        pubDate = bestSeller["published_date"].stringValue
        amazonURL = bestSeller["amazon_product_url"].stringValue
        rank = bestSeller["rank"].intValue
        weekOnList = bestSeller["weeks_on_list"].intValue
        bestSellerDate = bestSeller["bestsellers_date"].stringValue
        reviews = bestSeller["reviews"]
        bookDetails = bestSeller["book_details"]
        
        if !bookDetails.isEmpty{
            bookTitle = bookDetails[0]["title"].stringValue
            bookContributor = bookDetails[0]["contributor"].stringValue
            bookDescription = bookDetails[0]["description"].stringValue
            bookAuthor = bookDetails[0]["author"].stringValue
            bookPrimaryISBN10 = bookDetails[0]["primary_isbn10"].stringValue
            bookPrimaryISBN13 = bookDetails[0]["primary_isbn13"].stringValue
            bookPublisher = bookDetails[0]["publisher"].stringValue
        }
        
        if !reviews.isEmpty {
            sundayReview = reviews[0]["sunday_review_link"].stringValue
            firstChapter = reviews[0]["first_chapter_link"].stringValue
            articleChapter = reviews[0]["article_chapter_link"].stringValue
            bookReview = reviews[0]["book_review_link"].stringValue
        }
        
    }*/
    //Mark: Helper function to get data from API and save it to realm
    class func books(category: Category, dictionaries: JSON) {
        let realm = try! Realm()
        
        let dictionaryResult = dictionaries["results"]
        
        for (_, dictionary )in dictionaryResult {
            let book = BestSellerBooks()
            book.amazonURL = dictionary["amazon_product_url"].stringValue
            book.rank = dictionary["rank"].intValue
            book.weekOnList = dictionary["weeks_on_list"].intValue
            
            let reviews = dictionary["reviews"]
            if !reviews.isEmpty {
                book.sundayReview = reviews[0]["sunday_review_link"].stringValue
                book.firstChapter = reviews[0]["first_chapter_link"].stringValue
                book.articleChapter = reviews[0]["article_chapter_link"].stringValue
                book.bookReview = reviews[0]["book_review_link"].stringValue
            }
            let bookDetails = dictionary["book_details"]
            if !bookDetails.isEmpty {
                book.bookTitle = bookDetails[0]["title"].stringValue
                book.bookDescription = bookDetails[0]["description"].stringValue
                book.bookAuthor = bookDetails[0]["author"].stringValue
            }
            
            do {
                try realm.write {
                    category.bestSellerBook.append(book)
                }
            } catch {
                print("error saving to realm. Error: \(error) and \(error.localizedDescription)")
            }
        }
    }
    
}
