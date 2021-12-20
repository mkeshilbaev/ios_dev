//
//  ServicesViewController.swift
//  KbtuInformerApp
//
//  Created by Madi Keshilbayev on 12.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {
    
    var categories = ServiceCategory.allServices
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Services"
        view.backgroundColor = .systemBackground
    }
    
}
extension ServicesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].service.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "serviceCell")
        
        let service = categories[indexPath.section].service[indexPath.row]
        
        cell.textLabel?.text = service.title
        cell.detailTextLabel?.text = service.detail
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].title 
    }
    
    
    
}



