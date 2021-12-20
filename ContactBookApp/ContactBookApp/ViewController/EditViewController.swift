//
//  EditViewController.swift
//  ContactBookApp
//
//  Created by Madi Keshilbayev on 14.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    var selectedContactIndex: Int?
    var dataManager: DataManager?
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var genderPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Edit Contact"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(saveContactAndNavigateBack))
    }
    
    private func setupView() {
        nameTextField.text = dataManager?.contacts[selectedContactIndex!].name
        phoneNumberTextField.text = dataManager?.contacts[selectedContactIndex!].phoneNumber
        phoneNumberTextField.keyboardType = .numberPad
        
        let row = dataManager?.contacts[selectedContactIndex!].gender == "male" ? 0 : 1
        genderPickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
    @objc private func saveContactAndNavigateBack() {
        guard let name = nameTextField.text, let phoneNumber = phoneNumberTextField.text else { return }
        let gender = getGender()
        let editedContact = Contact.init(name, phoneNumber, gender)
        dataManager?.setContact(at: selectedContactIndex!, to: editedContact)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getGender() -> String {
        let row = genderPickerView.selectedRow(inComponent: 0)
        return row == 0 ? "male" : "female"
    }
    
    @IBOutlet weak var picker: UIPickerView!
}

// MARK:- Picker View
extension EditViewController: UIPickerViewDelegate, UIPickerViewDataSource  {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "male"
        } else if row == 1 {
            return "female"
        }
        return nil
    }

}
