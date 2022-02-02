//
//  HomeViewTableViewCell.swift
//  Bookmeister
//
//  Created by Madi Keshilbayev on 01.05.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class HomeViewTableViewCell: UITableViewCell {
   
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(title: String?, author: String?){
        self.author.text = author
        self.nameLabel.text = title
    }
}
