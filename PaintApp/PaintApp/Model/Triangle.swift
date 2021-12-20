//
//  Triangle.swift
//  PaintApp
//
//  Created by Madi Keshilbayev on 19.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation
import UIKit

class Triangle: Shape {
    var startingPoint: CGPoint
    var endingPoint: CGPoint
    var color: UIColor
    var isFilled: Bool
    
    lazy var leftTopPoint: CGPoint = {
        return CGPoint(x: leftX, y: topY)
    }()
    
    lazy var rightTopPoint: CGPoint = {
        return CGPoint(x: rightX, y: topY)
    }()
    
    lazy var leftBottomPoint: CGPoint = {
        return CGPoint(x: leftX, y: bottomY)
    }()
    
    lazy var rightBottomPoint: CGPoint = {
        return CGPoint(x: rightX, y: bottomY)
    }()
    
    lazy var rightX: CGFloat = {
        return endingPoint.x > startingPoint.x ? endingPoint.x : startingPoint.x
    }()
    
    lazy var leftX: CGFloat = {
        return endingPoint.x < startingPoint.x ? endingPoint.x : startingPoint.x
    }()
    
    lazy var topY: CGFloat = {
        return endingPoint.y < startingPoint.y ? endingPoint.y : startingPoint.y
    }()
    
    lazy var bottomY: CGFloat = {
        return endingPoint.y > startingPoint.y ? endingPoint.y : startingPoint.y
    }()
    
    init(startingPoint: CGPoint,
         endingPoint: CGPoint,
         color: UIColor,
         isFilled: Bool) {
        self.startingPoint = startingPoint
        self.endingPoint = endingPoint
        self.color = color
        self.isFilled = isFilled
    }
    
    func draw() {
        let path = UIBezierPath()
        path.move(to: leftTopPoint)
        path.addLine(to: leftBottomPoint)
        path.move(to: leftBottomPoint)
        path.addLine(to: rightBottomPoint)
        path.move(to: rightBottomPoint)
        path.addLine(to: leftTopPoint)
        path.lineWidth = strokeWidth
        color.set()
        isFilled ? path.fill() : path.stroke()
    }
    
}
