//
//  BestSellerViewController.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/9/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class BestSellerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var category: Category!
    var bestSeller: [BestSellerBooks] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        self.title = category.displayName
        // Do any additional setup after loading the view.
        fetchBestSellerBooks()
    }
    

    func fetchBestSellerBooks() {
      
        NYTApiClient().getBestSellerBooks(categoryName: category.listNameEncoded) { (books: [BestSellerBooks]?, error: Error?) in
            if let books = books {
                self.bestSeller = books
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func sortBy(_ sender: UISegmentedControl) {
        
        print(sender.selectedSegmentIndex)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bestSeller.isEmpty {
            return 0
        } else {
            return bestSeller.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestSellerBooksCell", for: indexPath) as! BestSellerBooksCell
        
        cell.bestSellerBook = bestSeller[indexPath.row]
        return cell
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
