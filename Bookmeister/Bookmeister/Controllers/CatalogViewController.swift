//
//  CatalogViewController.swift
//  Bookmeister
//
//  Created by Madi Keshilbayev on 01.05.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CatalogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var current_user: User?
    var genres: [Genre] = []
    let dataProvider = DataProvider()
    @IBOutlet var my_table_view: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_user = Auth.auth().currentUser!
        my_table_view.separatorStyle = .none
        dataProvider.getGenres() { [weak self] (genres) in
            self?.genres = genres
            DispatchQueue.main.async {
                self?.my_table_view.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath) as? CatalogTableViewCell else { return UITableViewCell() }
        let genre = genres[indexPath.row]
        URLSession.shared.dataTask(with: URL(string: genre.pictureUrl)!) { (data, response, error) in
            if error != nil {
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    cell.genreImageView.image = UIImage(data: data)
                }
            }
        }.resume()
        cell.configure(title: genre.title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genre = genres[indexPath.row]
        routeToDetails(genre: genre)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let translationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0)
        cell.layer.transform = translationTransform
        UIView.animate(withDuration: 0.3, delay: 0.2 * Double(indexPath.row), options: .curveEaseOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
    }

    private func routeToDetails(genre: Genre) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "BooksInGenreViewController") as? BooksInGenreViewController else { return }
        viewController.configure(genre: genre)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
