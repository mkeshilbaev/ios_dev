//
//  SearchViewController.swift
//  Bookmeister
//
//  Created by Madi Keshilbayev on 01.05.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var current_user: User?
    let searchController = UISearchController(searchResultsController: nil)
    var books: [Book] = []
    var filteredBooks: [Book] = []
    var filtered = false
    let dataProvider = DataProvider()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar

        current_user = Auth.auth().currentUser!
        tableView.separatorStyle = .none
        dataProvider.getBooks { [weak self] (books) in
            self?.books = books
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController){
        filterContent(searchText: self.searchController.searchBar.text!)
    }

    func filterContent(searchText: String){
        self.filteredBooks = books.filter{ book in
            let book = book.title as? String
            return(book?.lowercased().contains(searchText.lowercased()))!
        }
        tableView.reloadData()
        filtered = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive && searchController.searchBar.text != ""){
            return filteredBooks.count
        }
        return filtered ? 0 : self.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? HomeViewTableViewCell else { return UITableViewCell() }
       
        var book = books[indexPath.row]
        
        if (searchController.isActive && searchController.searchBar.text != ""){
            book = filteredBooks[indexPath.row]
        }else{
            book = self.books[indexPath.row]
        }
        
        URLSession.shared.dataTask(with: URL(string: book.pictureUrl)!) { (data, response, error) in
            if error != nil {
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    cell.bookImageView.image = UIImage(data: data)
                }
            }
        }.resume()
        cell.configure(title: book.title, author: book.author)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        routeToDetails(book: book)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let translationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0)
        cell.layer.transform = translationTransform
        UIView.animate(withDuration: 0.2, delay: 0.2 * Double(indexPath.row), options: .curveEaseOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
    }

    private func routeToDetails(book: Book) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "BookViewController") as? BookViewController else { return }
        viewController.configure(book: book)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

    
    


