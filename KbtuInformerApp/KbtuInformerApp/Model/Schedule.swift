//
//  Schedule.swift
//  KbtuInformerApp
//
//  Created by Madi Keshilbayev on 13.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation

struct ScheduleCategory {
    var title: String
    var schedule: [Schedule]
}


struct Schedule {
    var title: String
    var detail: String
}


extension ScheduleCategory {
    
    static var allSchedules: [ScheduleCategory] {
        return [
            ScheduleCategory(title: "Monday", schedule: [
                
            Schedule(title: "10:00-12:00",
                   detail: "Calculus 2"),
            Schedule(title: "12:00 - 14:00",
                   detail: "PLT"),

            ]),
            
            
            
            ScheduleCategory(title: "Tuesday", schedule: [
                
            Schedule(title: "08:00-11:00",
                   detail: "PP 2"),
            Schedule(title: "12:00 - 13:00",
                   detail: "Database"),

            ]),
            
            ScheduleCategory(title: "Thursday", schedule: [
                
            Schedule(title: "15:00-18:00",
                   detail: "iOS programming"),

            ]),
            
            ScheduleCategory(title: "Friday", schedule: [
                
            Schedule(title: "10:00-12:00",
                   detail: "Physics"),
            Schedule(title: "12:00 - 14:00",
                   detail: "OOP"),
            Schedule(title: "15:00 - 16:00",
                     detail: "Django")

            ]),
        ]
        
        
    }
}
