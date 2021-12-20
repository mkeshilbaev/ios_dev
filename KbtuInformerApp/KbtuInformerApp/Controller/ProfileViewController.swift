//
//  ProfileViewController.swift
//  KbtuInformerApp
//
//  Created by Madi Keshilbayev on 12.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    var categories = StudentInfoCategory.allStudentInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
    }
    
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].studentInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "profileCell")
        
        let studentInfo = categories[indexPath.section].studentInfo[indexPath.row]
        
        cell.textLabel?.text = studentInfo.title
        cell.detailTextLabel?.text = studentInfo.detail
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].title
    }
    
    

}






