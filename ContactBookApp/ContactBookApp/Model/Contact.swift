//
//  Contact.swift
//  ContactBookApp
//
//  Created by Madi Keshilbayev on 14.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation

struct Contact {
    var name: String
    var phoneNumber: String
    var gender: String
    
    init(_ name: String, _ phoneNumber: String, _ gender: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.gender = gender
    }
    
}
