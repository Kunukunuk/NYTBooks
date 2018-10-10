//
//  BookCell.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/9/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var book: Books! {
        didSet{
            categoryLabel.text = book.listNameEncoded
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
