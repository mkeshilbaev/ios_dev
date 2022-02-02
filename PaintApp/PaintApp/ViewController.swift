//
//  ViewController.swift
//  PaintApp
//
//  Created by Madi Keshilbayev on 18.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var canvas: CanvasView!
    
    @IBOutlet weak var undoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(resetCanvas))
        undoButton.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    
    @IBAction func changeShape(_ sender: UIButton) {
        guard let image = sender.imageView?.image else { return }
        switch image {
        case UIImage.init(named: "circle"):
            canvas.shapeType = .circle
        case UIImage.init(named: "rectangle"):
            canvas.shapeType = .rectangle
        case UIImage.init(named: "line"):
            canvas.shapeType = .line
        case UIImage.init(named: "triangle"):
            canvas.shapeType = .triangle
        case UIImage.init(named: "pen"):
            canvas.shapeType = .pen
        default:
            break
        }
    }
    
    
    @IBAction func fill(_ sender: UISwitch) {
        canvas.isFilled = sender.isOn
    }
    
    
    @IBAction func setColor(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        canvas.color = color
    }
    
    @IBAction func undo(_ sender: Any) {
        canvas.undo()
    }
    
    @objc private func resetCanvas() {
        canvas.reset()
    }
}

