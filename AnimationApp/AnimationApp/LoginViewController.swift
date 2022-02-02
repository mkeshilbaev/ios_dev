//
//  LoginViewController.swift
//  AnimationApp
//
//  Created by Madi Keshilbayev on 02.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 10
        loginButton.alpha = 0
        loginButton.layer.borderColor = UIColor.white.cgColor
        UIView.animate(withDuration: 1.3,
                       delay: 0.7,
                       options: .curveEaseInOut,
                       animations: {
                        self.loginButton.alpha = 1
                        
        })
        
        loginTF.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0)
        UIView.animate(withDuration: 0.9,
                       delay: 0.4,
                       options: .curveEaseInOut,
                       animations: {
                        self.loginTF.layer.transform = CATransform3DIdentity
        })
        
        passwordTF.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 500, 0, 0)
        UIView.animate(withDuration: 0.9,
                       delay: 0.4,
                       options: .curveEaseInOut,
                       animations: {
                        self.passwordTF.layer.transform = CATransform3DIdentity
        })
        
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "PhoneTableViewController") as! PhoneTableViewController
//        navigationController?.pushViewController(vc, animated: true)
    }


  

}
