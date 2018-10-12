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
    let getUpdate = UserDefaults.standard.bool(forKey: "getUpdate")
    let date = Date()
    let calendar = Calendar(identifier: .gregorian)
    
    var categoryResult: Results<Category>?
    let realm = try! Realm()
    @IBOutlet weak var tableView: UITableView!
    
    //Mark: - Loads and checks to call api or load from database, check if it's time to update
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
        
        if (sunday == 1 && getUpdate) {
            realm.deleteAll()
            saveCategoryToRealm()
            UserDefaults.standard.set(false, forKey: "getUpdate")
        } else if (sunday == 6){
            UserDefaults.standard.set(true, forKey: "getUpdate")
        }
    }
    
    // Mark - API call to NYT API and store the data on realm
    func saveCategoryToRealm() {
        let loading = MBProgressHUD.showAdded(to: self.view, animated: true)
        loading.label.text = "Getting Categories"
        
        NYTApiClient().getCategory { (error: Error?) in
            if error != nil {
                print("error description: \(error?.localizedDescription ?? "error")")
                loading.mode = .customView
                loading.customView = UIImageView(image: UIImage(named: "error.png"))
                loading.label.text = "Failed"
                loading.hide(animated: true, afterDelay: 1)
            } else {
                print("Saved successful")
                self.loadCategoryFromRealm()
                loading.mode = .customView
                loading.customView = UIImageView(image: UIImage(named: "check.png"))
                loading.label.text = "Finished"
                loading.hide(animated: true, afterDelay: 1)
            }
        }
        
    }
    
    // Mark: - load data from realm
    func loadCategoryFromRealm() {
        let loading = MBProgressHUD.showAdded(to: self.view, animated: true)
        loading.label.text = "Getting Categories"
        
        categoryResult = realm.objects(Category.self)
        
        tableView.reloadData()
        loading.mode = .customView
        loading.customView = UIImageView(image: UIImage(named: "check.png"))
        loading.label.text = "Loaded Data"
        loading.hide(animated: true, afterDelay: 1)
        
    }
    
    // Mark: - table view datasource for number of row
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryResult?.count ?? 1
    }
    
    // Mark: - table view datasource view for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        if let category = categoryResult?[indexPath.row] {
            cell.category = category
        }
       // cell.category = categoryResult?[indexPath.row] ?? cell.categoryLabel.text = "No Category"
        return cell
    }
    
    // Mark: - Change view controller and pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToBestSeller" {
            //let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! BestSellerViewController
                destinationVC.category = categoryResult?[indexPath.row]
            }
        }
    }

}

