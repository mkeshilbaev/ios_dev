//
//  Tweet.swift
//  Twitter
//
//  Created by Madi Keshilbayev on 13.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Tweet{
    var tweet: String?
    var author: String?
    var hashtag: String?
//    var date: NSDate?
    
    var dict: [String : String] {
        return [
            "tweet": tweet!,
            "author": author!,
            "hashtag": hashtag!,
//            "date": date!
        ]
    }
    
    init(_ tweet: String, _ author: String, _ hashtag: String) {
        self.tweet = tweet
        self.author = author
        self.hashtag = hashtag
//        self.date = date
    }
    
    init(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: String]{
            tweet = value["tweet"]!
            author = value["author"]!
            hashtag = value["hashtag"]!
//            author = value["author"]!
        }
    }
}
