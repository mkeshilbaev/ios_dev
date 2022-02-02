//
//  DetailViewController.swift
//  ContactBookApp
//
//  Created by Madi Keshilbayev on 13.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var name: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var selectedContactIndex: Int?
    var dataManager: DataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(navigateToEditVC))
    }
    
    func setupView() {
        self.name.text = dataManager?.contacts[selectedContactIndex!].name
        self.imageView.image = UIImage.init(named: dataManager?.contacts[selectedContactIndex!].gender ?? "")
    }
    
}

// MARK:- Table View
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell")
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "Phone number"
            cell?.detailTextLabel?.text = dataManager?.contacts[selectedContactIndex!].phoneNumber ?? ""
        case 1:
            cell?.textLabel?.text = "Gender"
            cell?.detailTextLabel?.text = dataManager?.contacts[selectedContactIndex!].gender.capitalized ?? ""
        default:
            break
        }
        
        return cell!
    }
    
}

// MARK:- Navigation
extension DetailViewController {
    
    @objc private func navigateToEditVC() {
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        editVC.selectedContactIndex = selectedContactIndex
        editVC.dataManager = dataManager
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
}
