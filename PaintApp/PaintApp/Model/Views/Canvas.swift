//
//  Canvas.swift
//  PaintApp
//
//  Created by Madi Keshilbayev on 19.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class CanvasView: UIView {

    var startingPoint: CGPoint?
    var endingPoint: CGPoint!
    var color: UIColor = .black
    var isFilled: Bool = false
    var shapeType: ShapeType?
    
    var shapes = [Shape]()
    
    override func draw(_ rect: CGRect) {
        for shape in shapes {
            shape.draw()
        }
        if startingPoint != nil {
            draw()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            startingPoint = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let shapeType = shapeType else { return }
        if shapeType == .pen {
            endingPoint = touches.first?.location(in: self)
            shapes.append(Line(startingPoint: startingPoint!,
                               endingPoint: endingPoint,
                               color: color))
            startingPoint = endingPoint
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            endingPoint = touch.location(in: self)
        }
        setNeedsDisplay()
    }
    
    private func draw() {
        guard let shapeType = shapeType else { return }
        let shape: Shape
        switch shapeType {
        case .circle:
            shape = Circle(startingPoint: startingPoint!,
                           endingPoint: endingPoint,
                           color: color,
                           isFilled: isFilled)
        case .rectangle:
            shape = Rectangle(startingPoint: startingPoint!,
                              endingPoint: endingPoint,
                              color: color,
                              isFilled: isFilled)
        case .triangle:
            shape = Triangle(startingPoint: startingPoint!,
                             endingPoint: endingPoint,
                             color: color,
                             isFilled: isFilled)
        case .line:
            shape = Line(startingPoint: startingPoint!,
                         endingPoint: endingPoint,
                         color: color)
        case .pen:
            shape = Pen(startingPoint: startingPoint!,
                         endingPoint: endingPoint,
                         color: color)
        }
        shape.draw()
        shapes.append(shape)
    }
    
    func undo() {
        guard !shapes.isEmpty else { return }
        shapes.removeLast()
        startingPoint = nil
        setNeedsDisplay()
    }
    
    func reset() {
        startingPoint = nil
        shapes = [Shape]()
        setNeedsDisplay()
    }
}
