//
//  ViewController.swift
//  KbtuInformerApp
//
//  Created by Madi Keshilbayev on 11.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 28)!,
            NSAttributedString.Key.foregroundColor: UIColor.systemPurple
        ]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
    }


}
