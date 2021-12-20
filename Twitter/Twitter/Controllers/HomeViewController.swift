//
//  HomeViewController.swift
//  Twitter
//
//  Created by Madi Keshilbayev on 08.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var current_user: User?
    var tweets: [Tweet] = []
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
           current_user = Auth.auth().currentUser!
           
        
           let parent = Database.database(url: "https://twitter-8eeb6-default-rtdb.europe-west1.firebasedatabase.app").reference().child("tweets")
           parent.observe(.value){ [weak self] (snapshot) in
               self?.tweets.removeAll()
               for child in snapshot.children{
                   if let snap =  child as? DataSnapshot{
                       let tweet = Tweet(snapshot: snap)
                       self?.tweets.append(tweet)
                   }
               }
               self?.tweets.reverse()
               self?.my_table_view.reloadData()
           }
       }
       
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction.init(style: .normal, title: "Edit") { (rowAction, indexPath) in
//            let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditTweetViewController") as! EditTweetViewController
////            editVC.selectedTweetIndex = indexPath.row
//            self.navigationController?.pushViewController(editVC, animated: true)
            
//            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            let editTweetPage = storyboard.instantiateViewController(withIdentifier: "EditTweetViewController") as! EditTweetViewController
//            editTweetPage.modalPresentationStyle = .fullScreen
//            self.present(editTweetPage, animated: true, completion: nil)
//              self.navigationController?.pushViewController(editTweetPage, animated: true)
            
            let editTweetPage = self.storyboard?.instantiateViewController(withIdentifier: "EditTweetViewController") as! EditTweetViewController
//            editTweetPage.selectedTweetIndex = tweets[indexPath.row]
            self.present(editTweetPage, animated: true, completion: nil)

        }
        editAction.backgroundColor = .orange
        
        let deleteAction = UITableViewRowAction.init(style: .normal, title: "Delete") { (rowAction, indexPath) in
            let alert = UIAlertController.init(title: "Delete tweet", message: "Are you sure you want to delete the tweet?", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { _ in
                self.tweets.remove(at: indexPath.row)
                tableView.reloadData()
            }))
            alert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        deleteAction.backgroundColor = .red
        
        return [deleteAction, editAction]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
//        cell.textLabel?.text = tweets[indexPath.row].tweet
//        cell.detailTextLabel?.text = tweets[indexPath.row].author
//        return cell
            
          let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! HomeViewTableViewCell
          cell.name.text = tweets[indexPath.row].author
          cell.hashtag.text = tweets[indexPath.row].hashtag
          cell.tweet.text = tweets[indexPath.row].tweet
          cell.username.text = current_user?.email
        
//          cell.configure(name: tweets[indexPath.row].author,
//                         username: self.current_user?.email!,
//                         hashtag: tweets[indexPath.row].hashtag,
//                         tweet: tweets[indexPath.row].tweet)
        
          return cell
    }
    
    
    @IBOutlet weak var my_table_view: UITableView!
    
    
    @IBAction func compose(_ sender: UIBarButtonItem) {
//        let alert = UIAlertController(title: "New tweet", message: "Enter your tweet", preferredStyle: .alert)
//
//        alert.addTextField{ (textField) in
//            textField.placeholder = "What's up?"
//        }
//
//        alert.addAction(UIAlertAction(title: "Tweet", style: .default, handler: { [weak alert] (_) in
//            let textField = alert?.textFields![0]
//
//            let tweet = Tweet((textField!.text!), (self.current_user?.email!)!)
//
//            Database.database(url: "https://twitter-8eeb6-default-rtdb.europe-west1.firebasedatabase.app").reference().child("tweets")
//                .childByAutoId().setValue(tweet.dict)
//
//
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,
//                                             handler: { (_) in
//        }))
//
//        self.present(alert, animated: true, completion: nil)
    }
    
    
}
