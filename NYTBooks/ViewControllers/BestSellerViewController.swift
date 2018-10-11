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
    let defaultSort = UserDefaults.standard
    let sortKey = "lastSort"
    
    @IBOutlet weak var segmentSort: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        self.title = category.displayName
        
        fetchBestSellerBooks()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let lastSort = defaultSort.object(forKey: sortKey) {
            let lastIndex = lastSort as! Int
            segmentSort.selectedSegmentIndex = lastIndex
            sortBooks(selectedIndex: lastIndex)
        }
    }

    func fetchBestSellerBooks() {
      
        NYTApiClient().getBestSellerBooks(categoryName: category.listNameEncoded) { (books: [BestSellerBooks]?, error: Error?) in
            if let books = books {
                self.bestSeller = books
                self.tableView.reloadData()
            }
        }
    }
    
    func sortBooks(selectedIndex: Int) {
        
        if (selectedIndex == 0) {
            
            bestSeller.sort(by: {$0.rank < $1.rank} )
            tableView.reloadData()
            
        } else if (selectedIndex == 1) {
            
            bestSeller.sort(by: { $0.weekOnList > $1.weekOnList })
            tableView.reloadData()
            
        }
    }
    
    @IBAction func sortBy(_ sender: UISegmentedControl) {
        
        defaultSort.set(sender.selectedSegmentIndex, forKey: sortKey)
        sortBooks(selectedIndex: sender.selectedSegmentIndex)
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
