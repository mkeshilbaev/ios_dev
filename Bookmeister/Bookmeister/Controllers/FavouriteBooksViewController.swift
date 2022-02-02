//
//  FavouriteBokksViewController.swift
//  Bookmeister
//
//  Created by Madi Keshilbayev on 13.05.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//
import UIKit
import FirebaseAuth
import FirebaseDatabase

class FavouriteBooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var current_user: User?
    var books: [Book] = []
    let dataProvider = DataProvider()
    private var book: Book?
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_user = Auth.auth().currentUser!
        tableView.separatorStyle = .none
        dataProvider.getBooks { [weak self] (books) in
            self?.books = books.filter({ book in
                return book.isFavorite == true
            })
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction.init(style: .normal, title: "Delete") { [self] (rowAction, indexPath) in
            let alert = UIAlertController.init(title: "Delete Book", message: "Are you sure you want to delete a book?", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { _ in
//                guard var book = book else { return }
                var book = books[indexPath.row]
                book.isFavorite.toggle()
                self.book = books[indexPath.row]
                dataProvider.removeFromFavorite(book: book)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }))
            alert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        deleteAction.backgroundColor = .red
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? HomeViewTableViewCell else { return UITableViewCell() }
        let book = books[indexPath.row]
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
        UIView.animate(withDuration: 0.3, delay: 0.2 * Double(indexPath.row), options: .curveEaseOut, animations: {
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

