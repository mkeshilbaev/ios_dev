//
//  ViewController.swift
//  ContactBookApp
//
//  Created by Madi Keshilbayev on 08.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(navigateToAddVC))
    }
    
}

// MARK:- Table View
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.contacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction.init(style: .normal, title: "Edit") { (rowAction, indexPath) in
            let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
            editVC.dataManager = self.dataManager
            editVC.selectedContactIndex = indexPath.row
            self.navigationController?.pushViewController(editVC, animated: true)
        }
        editAction.backgroundColor = .orange
        
        let deleteAction = UITableViewRowAction.init(style: .normal, title: "Delete") { (rowAction, indexPath) in
            let alert = UIAlertController.init(title: "Delete Contact?", message: "Are you sure you want to delete contact \(self.dataManager.contacts[indexPath.row].name)?", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { _ in
                self.dataManager.deleteContact(at: indexPath.row)
                tableView.reloadData()
            }))
            alert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        deleteAction.backgroundColor = .red
        
        
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.selectedContactIndex = indexPath.row
        detailVC.dataManager = dataManager
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as? ContactCell
        let contact = dataManager.contacts[indexPath.row]
        set(contact: contact, to: &cell)
        return cell!
    }
    
    private func set(contact data: Contact, to cell: inout ContactCell?) {
        cell?.name.text = data.name
        cell?.phoneNumber.text = data.phoneNumber
        cell?.contactImage.image = UIImage.init(named: data.gender)!
    }
    
}

// MARK:- Navigation
extension ViewController {
    
    @objc private func navigateToAddVC() {
        let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        addVC.dataManager = dataManager
        navigationController?.pushViewController(addVC, animated: true)
    }
    
}

