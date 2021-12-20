//
//  SearchViewController.swift
//  Twitter
//
//  Created by Madi Keshilbayev on 17.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
   
    @IBOutlet weak var tableView: UITableView!
    
    var tweetsArray = [NSDictionary?]()
    var filteredTweets = [NSDictionary?]()
    
    var databaseRef = Database.database(url: "https://twitter-8eeb6-default-rtdb.europe-west1.firebasedatabase.app").reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
        databaseRef.child("tweets").queryOrdered(byChild: "hashtag").observe(.childAdded, with: { (snapshot) in
            self.tweetsArray.append(snapshot.value as! NSDictionary?)
            print("Tweets Array is here !!!!!!!!!!!!!!!!!")
            //insert the rows
            self.tableView.insertRows(at: [IndexPath(row:self.tweetsArray.count-1, section: 0)],
                                      with: UITableView.RowAnimation.automatic)
            }) { (error) in
                print(error.localizedDescription)
                print("error while inserting data into rows !!!!!!!!!!!!!!!!!!!!!!!!")
            }
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive && searchController.searchBar.text != ""){
            return filteredTweets.count
        }
        return self.tweetsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        
        let tweet: NSDictionary?
        
        if (searchController.isActive && searchController.searchBar.text != ""){
            tweet = filteredTweets[indexPath.row]
        }else{
            tweet = self.tweetsArray[indexPath.row]
        }
        cell.textLabel?.text = tweet?["tweet"] as? String
        cell.detailTextLabel?.text = tweet?["hashtag"] as? String
        
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController){
        filterContent(searchText: self.searchController.searchBar.text!)
    }
        
    func filterContent(searchText: String){
        self.filteredTweets = tweetsArray.filter{ tweet in
             let tweet = tweet!["hashtag"] as? String
            return(tweet?.lowercased().contains(searchText.lowercased()))!
        }
        tableView.reloadData()
    }
        
}

    
    


