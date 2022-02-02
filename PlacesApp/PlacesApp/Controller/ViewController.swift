//
//  ViewController.swift
//  PlacesApp
//
//  Created by Madi Keshilbayev on 20.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {
    
    @IBOutlet weak var myMap: MKMapView!
    
    
    var mapType: [Int : MKMapType] = [0: .hybrid, 1: .standard, 2: .satellite]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMap.mapType = .standard
    }
    
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        myMap.mapType = mapType[sender.selectedSegmentIndex] ?? .standard
    }
    
    
    
    @IBAction func longTap(_ sender: UILongPressGestureRecognizer) {
        //converts CGPoint to CLLocation2D
        let touchPoint = sender.location(in: self.myMap)
        let coordinate = self.myMap.convert(touchPoint, toCoordinateFrom: self.myMap)
        
         
        
        let alertController = UIAlertController(title: "New location", message: "Fill the fields", preferredStyle: .alert)
        
        alertController.addTextField{ (textfield) in
            textfield.placeholder = "Location"
        }
        
        alertController.addTextField{ (textfield) in
            textfield.placeholder = "Description"
        }
        
        let save = UIAlertAction(title: "OK", style: .default){ [weak self](alert) in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            
            
            let annotation = MKPointAnnotation()
            annotation.title = firstTextField.text
            annotation.subtitle = secondTextField.text
            annotation.coordinate = coordinate
            
            self?.myMap.addAnnotation(annotation)
//            myMap.setRegion(<#T##region: MKCoordinateRegion##MKCoordinateRegion#>, animated: <#T##Bool#>)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(save)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

