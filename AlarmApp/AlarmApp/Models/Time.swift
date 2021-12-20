//
//  Time.swift
//  AlarmApp
//
//  Created by Madi Keshilbayev on 12.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation

struct Time: CustomStringConvertible {
    
    var hour: Int
    var minute: Int
    
    var description: String {
        return "\(hour):\(minute)"
    }
    
    static func getTime(from date: Date) -> Time {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        return Time(hour: hour, minute: minute)
    }
}

