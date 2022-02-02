//
//  HomeViewTableViewCell.swift
//  Twitter
//
//  Created by Madi Keshilbayev on 15.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class HomeViewTableViewCell: UITableViewCell {
   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var hashtag: UILabel!
    @IBOutlet weak var tweet: UITextView!
//    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    public func configure(name: String?, username: String?, hashtag: String?, tweet: String?){
        self.name.text = name
        self.username.text = username
        self.hashtag.text = hashtag
        self.tweet.text = tweet
//        self.time.text = time
    }
    
    


}
