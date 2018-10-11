//
//  BestSellerViewController.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/9/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import RealmSwift

class BestSellerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var category: Category!
    var bestSeller: Results<BestSellerBooks>?
    let defaultSort = UserDefaults.standard
    let sortKey = "lastSort"
    let realm = try! Realm()
    
    @IBOutlet weak var segmentSort: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        self.title = category.displayName
        
        let exist = category.bestSellerBook
        
        if exist.isEmpty {
            saveBestSellerBooks()
        } else {
            loadCategoryBestSellerBooks()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let lastSort = defaultSort.object(forKey: sortKey) {
            let lastIndex = lastSort as! Int
            segmentSort.selectedSegmentIndex = lastIndex
            sortBooks(selectedIndex: lastIndex)
        }
    }

    func saveBestSellerBooks() {
      
        NYTApiClient().getBestSellerBooks(category: category, categoryName: category.listNameEncoded) { (error: Error?) in
            if error == nil {
                print("saved successfully")
                self.loadCategoryBestSellerBooks()
            } else {
                print("error saving: \(error?.localizedDescription ?? "error")")
            }
        }
    }
    
    func loadCategoryBestSellerBooks() {
        
        bestSeller = category.bestSellerBook.sorted(byKeyPath: "rank", ascending: true)
        tableView.reloadData()
        
    }
    
    func sortBooks(selectedIndex: Int) {
        
        if (selectedIndex == 0) {
            
            bestSeller = category.bestSellerBook.sorted(byKeyPath: "rank", ascending: true)
            tableView.reloadData()
            
        } else if (selectedIndex == 1) {
            
            bestSeller = category.bestSellerBook.sorted(byKeyPath: "weekOnList", ascending: false)
            tableView.reloadData()
            
        }
    }
    
    @IBAction func sortBy(_ sender: UISegmentedControl) {
        
        defaultSort.set(sender.selectedSegmentIndex, forKey: sortKey)
        sortBooks(selectedIndex: sender.selectedSegmentIndex)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bestSeller?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestSellerBooksCell", for: indexPath) as! BestSellerBooksCell
        cell.bestSellerBook = bestSeller?[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToBookDetails" {
            let destinationVC = segue.destination as! BookDetailsViewController
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell){
                destinationVC.bookDetails = bestSeller?[indexPath.row]
            }
            
        }
    }
}
