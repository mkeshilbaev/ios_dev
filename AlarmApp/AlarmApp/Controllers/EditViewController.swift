//
//  EditViewController.swift
//  AlarmApp
//
//  Created by Madi Keshilbayev on 12.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit


protocol EditViewControllerDelegate {
    func changeAlarm(at index: Int, to alarm: Alarm)
    func deleteAlarm(at index: Int)
}



class EditViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var alarmDate: UIDatePicker!
    
    var index: Int?
    var alarm: Alarm?
    var delegate: EditViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutlets()
        navigationItem.title = "Change Alarm"
    }
    
    private func configureOutlets() {
        alarmDate.date = getDate()!
        titleTextField.text = alarm?.title
    }
    
    private func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: String(describing: alarm!.time))
        return date
    }
    
    
    @IBAction func changeAlarm(_ sender: Any) {
        guard let title = titleTextField.text,
            let index = index else { return }
        let date = alarmDate.date
        let alarmModified = Alarm(title: title, time: Time.getTime(from: date))
        delegate?.changeAlarm(at: index, to: alarmModified)
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func deleteAlarm(_ sender: Any) {
        guard let index = index else { return }
        delegate?.deleteAlarm(at: index)
        navigationController?.popViewController(animated: true)
    }
}








