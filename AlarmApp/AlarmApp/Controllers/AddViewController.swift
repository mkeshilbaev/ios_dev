//
//  AddViewController.swift
//  AlarmApp
//
//  Created by Madi Keshilbayev on 12.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit


protocol AddViewControllerDelegate {
    func add(alarm: Alarm)
}


class AddViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    var delegate: AddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Alarm"
    }
    
    @IBAction func save(_ sender: Any) {
        guard let title = titleTextField.text else { return }
                let date = datePicker.date
                let alarm = Alarm(title: title, time: Time.getTime(from: date))
                delegate?.add(alarm: alarm)
                navigationController?.popViewController(animated: true)
    }
    
}
