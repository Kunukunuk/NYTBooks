//
//  BookDetailsViewController.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/10/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    var bookDetails: BestSellerBooks!
    var buttonLinks: [String: String] = [:]
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var amazonLink: UIButton!
    @IBOutlet weak var articleChapterLink: UIButton!
    @IBOutlet weak var bookReview: UIButton!
    @IBOutlet weak var firstChapterLink: UIButton!
    @IBOutlet weak var sundayReview: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookTitleLabel.text = bookDetails.bookTitle
        bookDescriptionLabel.text = bookDetails.bookDescription
        bookAuthorLabel.text = "Author: \(bookDetails.bookAuthor)"
        if bookDetails.amazonURL == "" {
            amazonLink.isEnabled = false
            amazonLink.setTitleColor(UIColor.gray, for: .disabled)
        }
        if bookDetails.articleChapter == "" {
            articleChapterLink.isEnabled = false
            articleChapterLink.setTitleColor(UIColor.gray, for: .disabled)
        }
        if bookDetails.bookReview == "" {
            bookReview.isEnabled = false
            bookReview.setTitleColor(UIColor.gray, for: .disabled)
        }
        if bookDetails.firstChapter == "" {
            firstChapterLink.isEnabled = false
            firstChapterLink.setTitleColor(UIColor.gray, for: .disabled)
        }
        if bookDetails.sundayReview == "" {
            sundayReview.isEnabled = false
            sundayReview.setTitleColor(UIColor.gray, for: .disabled)
        }
        
        buttonLinks["Amazon Link"] = bookDetails.amazonURL
        buttonLinks["Article Chapter Link"] = bookDetails.articleChapter
        buttonLinks["Book Review Link"] = bookDetails.bookReview
        buttonLinks["First Chapter Link"] = bookDetails.firstChapter
        buttonLinks["Sunday Review Link"] = bookDetails.sundayReview
    }
    
    
    @IBAction func goToReview(_ sender: UIButton) {
        
        let text = sender.titleLabel?.text
        let stringURL = buttonLinks[text!]
        
        guard let url = URL(string: stringURL!) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }

}
