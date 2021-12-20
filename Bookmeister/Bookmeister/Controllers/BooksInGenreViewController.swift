//
//  BooksInGenreViewController.swift
//  Bookmeister
//
//  Created by Madi Keshilbayev on 26.05.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class BooksInGenreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var current_user: User?
    var books: [Book] = []
    var filteredBooks: [Book] = []
    let dataProvider = DataProvider()
    private var genre: Genre?
    @IBOutlet var my_table_view: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_user = Auth.auth().currentUser!
        my_table_view.separatorStyle = .none
        
        dataProvider.getBooks { [weak self] (books) in
            self?.books = books.filter({ book in
                return book.genreId == self?.genre!.id
            })
            DispatchQueue.main.async {
                self?.my_table_view.reloadData()
            }
        }
//            filteredBooks = books.filter { book in
//                return book.genreId == genre.id
//            }
    }
    
    func configure(genre: Genre) {
        self.genre = genre
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? HomeViewTableViewCell else { return UITableViewCell() }
        let books = books[indexPath.row]
        URLSession.shared.dataTask(with: URL(string: books.pictureUrl)!) { (data, response, error) in
            if error != nil {
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    cell.bookImageView.image = UIImage(data: data)
                }
            }
        }.resume()
        cell.configure(title: books.title, author: books.author)
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
