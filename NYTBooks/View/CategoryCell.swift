//
//  CategoryCell.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/10/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    var category: Category? {
        didSet {
            categoryLabel.text = category?.displayName ?? "No Category"
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
