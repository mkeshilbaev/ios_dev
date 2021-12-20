//
//  HomeViewController.swift
//  Bookmeister
//
//  Created by Madi Keshilbayev on 01.05.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//
import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var current_user: User?
    var books: [Book] = []
    let dataProvider = DataProvider()
    @IBOutlet weak var my_table_view: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_user = Auth.auth().currentUser!
        my_table_view.separatorStyle = .none
        dataProvider.getBooks { [weak self] (books) in
            self?.books = books
            DispatchQueue.main.async {
                self?.my_table_view.reloadData()
            }
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        current_user = Auth.auth().currentUser!
//        my_table_view.separatorStyle = .none
//        dataProvider.getBooks { [weak self] (books) in
//            self?.books = books
//            DispatchQueue.main.async {
//                self?.my_table_view.reloadData()
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
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
