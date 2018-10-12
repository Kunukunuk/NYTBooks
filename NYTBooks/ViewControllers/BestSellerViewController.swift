//
//  BestSellerViewController.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/9/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import RealmSwift
import MBProgressHUD

class BestSellerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var category: Category!
    var bestSeller: Results<BestSellerBooks>?
    let defaultSort = UserDefaults.standard
    let sortKey = "lastSort"
    let realm = try! Realm()
    
    @IBOutlet weak var segmentSort: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //Mark: set title and checks if the realm object exist
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
    //Mark: Save the last sort by option
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let lastSort = defaultSort.object(forKey: sortKey) {
            let lastIndex = lastSort as! Int
            segmentSort.selectedSegmentIndex = lastIndex
            sortBooks(selectedIndex: lastIndex)
        }
    }

    //Mark: API call to get all the best seller books in the category
    func saveBestSellerBooks() {
        let loading = MBProgressHUD.showAdded(to: self.view, animated: true)
        loading.label.text = "Getting Book Names"
        NYTApiClient().getBestSellerBooks(category: category, categoryName: category.listNameEncoded) { (error: Error?) in
            if error == nil {
                print("saved successfully")
                self.loadCategoryBestSellerBooks()
                loading.mode = .customView
                loading.customView = UIImageView(image: UIImage(named: "check.png"))
                loading.label.text = "Finished"
                loading.hide(animated: true, afterDelay: 1)
            } else {
                print("error saving: \(error?.localizedDescription ?? "error")")
                loading.mode = .customView
                loading.customView = UIImageView(image: UIImage(named: "error.png"))
                loading.label.text = "Error"
                loading.hide(animated: true, afterDelay: 1)
            }
        }
    }
    
    //Mark: Loads data from realm
    func loadCategoryBestSellerBooks() {
        let loading = MBProgressHUD.showAdded(to: self.view, animated: true)
        loading.label.text = "Getting Book Names"
        
        bestSeller = category.bestSellerBook.sorted(byKeyPath: "rank", ascending: true)
        
        loading.mode = .customView
        loading.customView = UIImageView(image: UIImage(named: "check.png"))
        loading.label.text = "Loaded Data"
        loading.hide(animated: true, afterDelay: 1)
        tableView.reloadData()
        
    }
    
    //Mark: sort the listing
    func sortBooks(selectedIndex: Int) {
        
        if (selectedIndex == 0) {
            
            bestSeller = category.bestSellerBook.sorted(byKeyPath: "rank", ascending: true)
            tableView.reloadData()
            
        } else if (selectedIndex == 1) {
            
            bestSeller = category.bestSellerBook.sorted(byKeyPath: "weekOnList", ascending: false)
            tableView.reloadData()
            
        }
    }
    
    //Mark: Button to sort the listing of books
    @IBAction func sortBy(_ sender: UISegmentedControl) {
        
        defaultSort.set(sender.selectedSegmentIndex, forKey: sortKey)
        sortBooks(selectedIndex: sender.selectedSegmentIndex)
    }
    
    //Mark: Table view datasource for number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bestSeller?.count ?? 1
    }
    
    //Mark: Table view datasource for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestSellerBooksCell", for: indexPath) as! BestSellerBooksCell
        cell.bestSellerBook = bestSeller?[indexPath.row]
        return cell
    }
    
    //Mark: Change view controller and pass data
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
