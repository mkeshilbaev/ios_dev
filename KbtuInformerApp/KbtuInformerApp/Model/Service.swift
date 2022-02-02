//
//  Recipe.swift
//  KbtuInformerApp
//
//  Created by Madi Keshilbayev on 13.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation


struct ServiceCategory {
    var title: String
    var service: [Service]
}


struct Service {
    var title: String
    var detail: String
}


extension ServiceCategory {
    
    static var allServices: [ServiceCategory] {
        return [
            ServiceCategory(title: "Офис регистратора", service: [
                
            Service(title: "Получение ADD/DROP бланка",
                   detail: "в течении 1-2 часов придет на почту"),
            Service(title: "Drop предмета",
                   detail: "написать онлайн заявление"),
            Service(title: "Получение сверх кредита",
                   detail: "подать заявку и оплатить в инетернет банкинге"),
            Service(title: "Получение транскрипта на англ",
            detail: "подать заявку и ждать в течении 1-2 рабочих дня")
            ]),
            
            
            
            ServiceCategory(title: "Деканат", service: [
                
            Service(title: "Получение разрешение на свободное посещение",
                   detail: "написать онлайн заявление"),
            Service(title: "Обратиться по какому то вопросу",
                   detail: "оставьте свои предложения здесь")
            ])
        ]
        
        
    }
}
