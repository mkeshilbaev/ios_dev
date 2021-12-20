//
//  Student.swift
//  KbtuInformerApp
//
//  Created by Madi Keshilbayev on 13.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation

struct StudentInfoCategory {
    var title: String
    var studentInfo: [StudentInfo]
}


struct StudentInfo {
    var title: String
    var detail: String
}


extension StudentInfoCategory {
    
    static var allStudentInfo: [StudentInfoCategory] {
        return [
            StudentInfoCategory(title: "Student Info", studentInfo: [
                
            StudentInfo(title: "Faculty",
                   detail: "FIT"),
            StudentInfo(title: "Major",
                   detail: "Computer Science & Software"),
            StudentInfo(title: "GPA",
                   detail: "3.34"),
            StudentInfo(title: "Credits",
            detail: "65")
            ])
        ]
        
        
    }
}

