//
//  Pen.swift
//  PaintApp
//
//  Created by Madi Keshilbayev on 19.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation
import UIKit

class Pen: Shape {
    var startingPoint: CGPoint
    var endingPoint: CGPoint
    var color: UIColor
    var isFilled: Bool = true
    
    init(startingPoint: CGPoint, endingPoint: CGPoint, color: UIColor) {
        self.startingPoint = startingPoint
        self.endingPoint = endingPoint
        self.color = color
    }
    
    func draw() {
        let path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
    }
    
}
