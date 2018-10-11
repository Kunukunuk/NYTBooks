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
    var defaultBestSeller: [BestSellerBooks] = []
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
                self.defaultBestSeller = books
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func sortBy(_ sender: UISegmentedControl) {
        
       if (sender.selectedSegmentIndex == 0) {
            
            bestSeller.sort(by: {$0.rank < $1.rank} )
            tableView.reloadData()
            
        } else if (sender.selectedSegmentIndex == 1) {
            
            bestSeller.sort(by: { $0.weekOnList > $1.weekOnList })
            tableView.reloadData()
            
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToBookDetails" {
            let destinationVC = segue.destination as! BookDetailsViewController
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell){
                destinationVC.bookDetails = bestSeller[indexPath.row]
            }
            
        }
    }
}
