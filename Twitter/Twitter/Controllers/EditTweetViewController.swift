//
//  EditTweetViewController.swift
//  Twitter
//
//  Created by Madi Keshilbayev on 17.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EditTweetViewController: UIViewController {
    
    var tweets:[Tweet] = []
    var selectedTweetIndex: Int?
    var current_user: User?
    var databaseRef = Database.database(url: "https://twitter-8eeb6-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    @IBOutlet weak var tweetContent: UITextView!
    @IBOutlet weak var hashtag: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_user = Auth.auth().currentUser
//        setupView()
    }
    
    private func setupView() {
        databaseRef.child("tweets").child((current_user?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.tweetContent.text = value?["tweet"] as? String ?? "Error while fetching tweet content..."
            self.hashtag.text = value?["hashtag"] as? String ?? "Error while fetching tweet hashtag..."
        })
    }

    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func updateTweetTapped(_ sender: UIBarButtonItem) {
        guard let tweet = tweetContent.text else { return }
        guard let hashtag = hashtag.text else { return }

        databaseRef.child("tweets").child(current_user!.uid).updateChildValues(["tweet": tweet, "hashtag": hashtag, "author": current_user?.email]){
                (error:Error?, ref:DatabaseReference) in
                if let error = error{
                    print("Data could not be saved: \(error).")
                } else{
                    print("Data saved successfully!")
                    self.showMessage(title: "Success", message: "You have updated your tweet!")
                }
        }
    }
    
    func showMessage(title: String, message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                   
        //add and action (button)
        let ok = UIAlertAction(title: "OK", style: .default){ (UIAlertAction) in
            if title != "Error"{
                self.dismiss(animated: true, completion: nil)
            }
        }
            alert.addAction(ok)
                   
            //show the alert
            self.present(alert, animated: true, completion: nil)
    }
    
}

           
        
