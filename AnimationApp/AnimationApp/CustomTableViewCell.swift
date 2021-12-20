//
//  CustomTableViewCell.swift
//  AnimationApp
//
//  Created by Madi Keshilbayev on 02.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var initialView: UIView!
    @IBOutlet weak var detailedView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var processor: UILabel!
    @IBOutlet weak var camera: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        UIView.transition(from: initialView!,
                          to: detailedView!,
                          duration: 0.3,
                          options: [.transitionFlipFromRight, .showHideTransitionViews],
                          completion: nil)
    }
    
    
    @IBAction func hideButtonTapped(_ sender: UIButton) {
        UIView.transition(from: detailedView!,
                          to: initialView!,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews],
                          completion: nil)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

   
}
