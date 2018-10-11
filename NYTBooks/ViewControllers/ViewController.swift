//
//  ViewController.swift
//  NYTBooks
//
//  Created by Kun Huang on 10/9/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import RealmSwift
import MBProgressHUD

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let firstLaunch = UserDefaults.standard.bool(forKey: "launchedBefore")
    let date = Date()
    let calendar = Calendar(identifier: .gregorian)
    
    var categoryResult: Results<Category>?
    let realm = try! Realm()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        if firstLaunch {
            loadCategoryFromRealm()
        } else {
            saveCategoryToRealm()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        let sunday = calendar.component(.weekday, from: date)
        if sunday == 1 {
            saveCategoryToRealm()
        }
    }
    
    func saveCategoryToRealm() {
        
        NYTApiClient().getCategory { (error: Error?) in
            if error != nil {
                print("error description: \(error?.localizedDescription ?? "error")")
            } else {
                print("Saved successful")
                self.loadCategoryFromRealm()
            }
        }
        
    }
    
    func loadCategoryFromRealm() {
        
        categoryResult = realm.objects(Category.self)
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryResult?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        if let category = categoryResult?[indexPath.row] {
            cell.category = category
        }
       // cell.category = categoryResult?[indexPath.row] ?? cell.categoryLabel.text = "No Category"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToBestSeller" {
            //let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! BestSellerViewController
                destinationVC.category = categoryResult?[indexPath.row]
            }
           /* if let indexPath = tableView.indexPath(for: cell){
                let destinationVC = segue.destination as! BestSellerViewController
                destinationVC.category = category[indexPath.row]
            }*/
        }
    }

}

