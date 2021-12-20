//
//  EmailViewController.swift
//  KbtuInformerApp
//
//  Created by Madi Keshilbayev on 11.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import SafariServices

class EmailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTapped()
    }
    
    
    
    func buttonTapped(){
        guard let url = URL(string:"https://outlook.office365.com/mail/inbox") else{
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)
    }

}




