//
//  EditProfileViewController.swift
//  Bookmeister
//
//  Created by Madi Keshilbayev on 01.05.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EditProfileViewController: UIViewController {
    
    var current_user: User?
    var databaseRef = Database.database().reference()

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var birth_date: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm_password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        current_user = Auth.auth().currentUser
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmTapped(_ sender: UIButton) {
        guard let name = name.text else { return }
        guard let surname = surname.text else { return }
        guard let password = password.text else { return }
        guard let birth_date = birth_date.text else { return }
        
        databaseRef.child("users").child(current_user!.uid).updateChildValues(["name": name,
                                                                               "surname": surname,
                                                                               "email": current_user?.email!,
                                                                               "birth_date": birth_date,
                                                                               "password": password]){
            (error:Error?, ref:DatabaseReference) in
            if let error = error{
                print("Data could not be saved: \(error).")
            } else{
                print("Data saved successfully!")
                self.showMessage(title: "Success", message: "You have changed your data!")
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
