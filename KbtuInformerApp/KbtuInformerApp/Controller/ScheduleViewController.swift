//
//  ScheduleViewController.swift
//  KbtuInformerApp
//
//  Created by Madi Keshilbayev on 13.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    var categories = ScheduleCategory.allSchedules
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"
        view.backgroundColor = .systemBackground
    }
    
}


extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].schedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "scheduleCell")
        
        let schedule = categories[indexPath.section].schedule[indexPath.row]
        
        cell.textLabel?.text = schedule.title
        cell.detailTextLabel?.text = schedule.detail
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].title
    }
    
    
    
}
