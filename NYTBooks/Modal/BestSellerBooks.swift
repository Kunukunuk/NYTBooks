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
    
    var bookTitle: String?
    var bookContributor: String?
    var bookDescription: String?
    var bookAuthor: String?
    var bookPrimaryISBN10: String?
    var bookPrimaryISBN13: String?
    var bookPublisher: String?
    
    var sundayReview: String?
    var firstChapter: String?
    var articleChapter: String?
    var bookReview: String?
    
    init(bestSeller: JSON) {
        
        print("seller: \(bestSeller)")
        displayName = bestSeller["display_name"].stringValue
        rankLastWeek = bestSeller["rank_last_week"].intValue
        pubDate = bestSeller["published_date"].stringValue
        amazonURL = bestSeller["amazon_product_url"].stringValue
        rank = bestSeller["rank"].intValue
        weekOnList = bestSeller["week_on_list"].intValue
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
