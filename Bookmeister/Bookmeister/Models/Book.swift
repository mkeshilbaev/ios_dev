//
//  Book.swift
//  Bookmeister
//
//  Created by Madi Keshilbayev on 01.05.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import FirebaseDatabase


struct Book: Encodable {
    var title: String
    var author: String
    var description: String
    var pictureUrl: String
    var audioUrl: String
    var year: String
    var language: String
    var genreId: Int
    var id: Int
    var isFavorite: Bool
    
    var dict: [String: Any] {
        return [
            "title": title,
            "author": author,
            "description": description,
            "audio_url": audioUrl,
            "picture_url": pictureUrl,
            "year": year,
            "genre": genreId,
            "id": id,
            "isFavorite": isFavorite,
            "language": language,
        ]
    }

    init?(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: Any],
            let title = value["title"] as? String,
            let author = value["author"] as? String,
            let description = value["description"] as? String,
            let picture_url = value["picture_url"] as? String,
            let audio_url = value["audio_url"] as? String,
            let year = value["year"] as? String,
            let language = value["language"] as? String,
            let genreId = value["genre"] as? Int,
            let id = value["id"] as? Int,
            let isFavorite = value["isFavorite"] as? Bool
        {
            self.title = title
            self.author = author
            self.description = description
            self.pictureUrl = picture_url
            self.audioUrl = audio_url
            self.language = language
            self.genreId = genreId
            self.year = year
            self.id = id
            self.isFavorite = isFavorite
        } else {
            return nil
        }
    }
    
}
