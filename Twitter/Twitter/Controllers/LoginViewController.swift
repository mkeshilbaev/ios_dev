//
//  LoginViewController.swift
//  Twitter
//
//  Created by Madi Keshilbayev on 08.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var current_user: User?
    @IBOutlet weak var email_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_user = Auth.auth().currentUser
    }
    
    override func viewDidAppear(_ animated: Bool){
        current_user = Auth.auth().currentUser
        if current_user != nil && current_user!.isEmailVerified{
            gotoMainPage()
        }
    }
    
    @IBAction func login_clicked(_ sender: UIButton) {
        let email = email_field.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password_field.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        indicator.startAnimating()
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self]
            (result, error) in
            self?.indicator.stopAnimating()
            if error == nil {
                if Auth.auth().currentUser!.isEmailVerified{
                    //go to main page
                    self?.gotoMainPage()
                } else{
                    self?.showMessage(title: "Warning", message: "Email was not verified!")
                }
            }else{
                self?.showMessage(title: "Error", message: "Invalid username/password!")
            }
          
        }
    }
    
    @IBAction func register_clicked(_ sender: UIButton) {
        
    }
    
    
    func showMessage(title: String, message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //add and action (button)
        let ok = UIAlertAction(title: "OK", style: .default){ (UIAlertAction) in
        }
        alert.addAction(ok)
        
        //show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func gotoMainPage(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let mainPage = storyboard.instantiateViewController(identifier: "MainTabBarController") as? UITabBarController{
            
            mainPage.modalPresentationStyle = .fullScreen
            present(mainPage, animated: true, completion: nil)
        }
    }

}
