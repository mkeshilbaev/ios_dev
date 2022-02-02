//
//  CustomSegue.swift
//  AnimationApp
//
//  Created by Madi Keshilbayev on 01.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue
{
    
    override func perform()
    {
        let destination_view = self.destination.view
        let source_view = self.source.view
        
        UIView.animate(withDuration: 1,
                       animations:{
                        source_view?.alpha = 0
            }){(Bool) in
                destination_view?.alpha = 0
                self.source.present(self.destination,
                                animated: false){
                                    UIView.animate(withDuration: 2){
                                        destination_view?.alpha = 1
                                    }
                }
            
            }
     }

}
