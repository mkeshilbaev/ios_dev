//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Madi Keshilbayev on 15.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class NewTweetViewController: UIViewController {

    @IBOutlet weak var newTweetTextView: UITextView!
    @IBOutlet weak var hashtagTextField: UITextField!
    
    //create reference to db
    var databaseRef = Database.database(url: "https://twitter-8eeb6-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    var current_user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_user = Auth.auth().currentUser!
        
//        newTweetTextView.textContainerInset = UIEdgeInsets(top:30, left:20, bottom:20, right:20)
//        newTweetTextView.text = "What's happenning?"
//        newTweetTextView.textColor = UIColor.lightGray
    }
    
//    func textViewDidBeginEditing(textView: UITextView){
//        if(newTweetTextView.textColor == UIColor.lightGray){
//            newTweetTextView.text = ""
//            newTweetTextView.textColor = UIColor.black
//        }
//    }
    
    @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapTweet(_ sender: UIBarButtonItem) {
        let tweet = Tweet((newTweetTextView.text!), (self.current_user?.email!)!, (hashtagTextField.text!))
        
        if(newTweetTextView.text != ""){
            
            Database.database(url: "https://twitter-8eeb6-default-rtdb.europe-west1.firebasedatabase.app").reference().child("tweets").childByAutoId().setValue(tweet.dict)
            
//            let key = self.databaseRef.child("tweets").childByAutoId().key
//            let childUpdates = ["/tweets/\(self.loggedInUser!.uid)\(key)\text": newTweetTextView.text,
//                                "/tweets/\(self.loggedInUser!.uid)\(key)\timestamp": "\(NSDate().timeIntervalSince1970)"] as [String : Any]
//            self.databaseRef.updateChildValues(childUpdates)
            
            dismiss(animated: true, completion: nil)
        }
    }

    
}
