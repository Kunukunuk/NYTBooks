//
//  BookDetailsView.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/10/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class BookDetailsView: UIView {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var amazonLink: UIButton!
    @IBOutlet weak var bookReview: UIButton!
    @IBOutlet weak var sundayReview: UIButton!
    @IBOutlet weak var firstChapterLink: UIButton!
    @IBOutlet weak var aritcleChapterLink: UIButton!
    
    var bookDetails: BestSellerBooks! {
        didSet {
            bookTitleLabel.text = bookDetails.bookTitle
            bookDescriptionLabel.text = bookDetails.bookDescription
            bookAuthorLabel.text = "Author: \(bookDetails.bookAuthor ?? "No Author")"
            if bookDetails.amazonURL != "" {
                amazonLink.setTitle("have link", for: .normal)
            } else {
                amazonLink.setTitle("no link", for: .normal)
            }
            if bookDetails.articleChapter != "" {
                aritcleChapterLink.setTitle("have link", for: .normal)
            } else {
                aritcleChapterLink.setTitle("no link", for: .normal)
            }
            if bookDetails.bookReview != "" {
                bookReview.setTitle("have link", for: .normal)
            } else {
                bookReview.setTitle("no link", for: .normal)
            }
            if bookDetails.firstChapter != "" {
                firstChapterLink.setTitle("have link", for: .normal)
            } else {
                firstChapterLink.setTitle("no link", for: .normal)
            }
            if bookDetails.sundayReview != "" {
                sundayReview.setTitle("have link", for: .normal)
            } else {
                sundayReview.setTitle("no link", for: .normal)
            }
            
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
