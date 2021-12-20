//
//  ContactCell.swift
//  ContactBookApp
//
//  Created by Madi Keshilbayev on 14.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import Foundation


//Custom cell
class ContactCell: UITableViewCell {

    @IBOutlet var contactImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var phoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

