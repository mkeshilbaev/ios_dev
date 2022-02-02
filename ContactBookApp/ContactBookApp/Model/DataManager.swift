//
//  DataManager.swift
//  ContactBookApp
//
//  Created by Madi Keshilbayev on 14.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation

class DataManager {
    
    var contacts: [Contact] = [
        Contact.init("Madi", "+77754993321", "male"),
        Contact.init("Gulzhapyrak", "+77072293775", "female")
    ]
    
    func add(_ contact: Contact) {
        contacts.append(contact)
    }
    
    func deleteContact(at index: Int) {
        contacts.remove(at: index)
    }
    
    func setContact(at index: Int, to contact: Contact) {
        contacts[index] = contact
    }
    
}
