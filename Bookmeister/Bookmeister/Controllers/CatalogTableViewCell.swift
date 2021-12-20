//
//  CatalogTableViewCell.swift
//  Bookmeister
//
//  Created by Madi Keshilbayev on 26.05.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class CatalogTableViewCell: UITableViewCell {
    
    @IBOutlet var genreImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(title: String?){
        self.nameLabel.text = title
    }
}



