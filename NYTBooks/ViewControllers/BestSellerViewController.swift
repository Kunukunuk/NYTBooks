//
//  BestSellerViewController.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/9/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class BestSellerViewController: UIViewController {

    
    var book: Books!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchBestSellerBooks()
    }
    

    func fetchBestSellerBooks() {
        NYTApiClient().getBestSellerBooks(categoryName: book.listNameEncoded!) { (books: [Books]?, error: Error?) in
            if let books = books {
                print("books: \(books)")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
