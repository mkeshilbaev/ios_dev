//
//  DataProvider.swift
//  Bookmeister
//
//  Created by Madi Keshilbayev on 02.05.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation
import Firebase

class DataProvider {
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func getBooks(completion: (([Book]) -> Void)? = nil) {
        ref.child("books").getData { (error, snapshot) in
            let count = snapshot.childrenCount
            var books: [Book] = []
            for index in stride(from: 1, through: count, by: 1) {
//                stride(from: 1, through: count, by: 1)
                let bookSnapshot = snapshot.childSnapshot(forPath: "\(index)")
                let book = Book(snapshot: bookSnapshot)
                
                if let book = book {
                    books.append(book)
                }
            }
            completion?(books)
        }
    }
    
    
    func addToFavorite(book: Book) {
        ref.child("books").child("\(book.id)").setValue(book.dict)
    }
    
    func removeFromFavorite(book: Book) {
        ref.child("books").child("\(book.id)").setValue(book.dict)
    }
    
    func getGenres(completion: (([Genre]) -> Void)? = nil) {
        ref.child("genres").getData { (error, snapshot) in
            let count = snapshot.childrenCount
            var genres: [Genre] = []
            for index in stride(from: 1, through: count, by: 1) {
                let genreSnapshot = snapshot.childSnapshot(forPath: "\(index)")
                let genre = Genre(snapshot: genreSnapshot)
                
                if let genre = genre {
                    genres.append(genre)
                }
            }
            completion?(genres)
        }
    }
    
    
    
    
}
