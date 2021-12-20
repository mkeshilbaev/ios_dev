//
//  Shape.swift
//  PaintApp
//
//  Created by Madi Keshilbayev on 19.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation
import UIKit

protocol Shape {
    var startingPoint: CGPoint { get set }
    var endingPoint: CGPoint { get set }
    var color: UIColor { get set }
    var isFilled: Bool { get set }
    var strokeWidth: CGFloat { get }
    
    func draw()
}

extension Shape {
    var strokeWidth: CGFloat { return 4.0 }
}

enum ShapeType {
    case circle
    case rectangle
    case triangle
    case line
    case pen
}



