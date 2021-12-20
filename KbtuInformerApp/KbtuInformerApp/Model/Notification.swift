//
//  Notification.swift
//  KbtuInformerApp
//
//  Created by Madi Keshilbayev on 13.03.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import Foundation


struct NotificationCategory {
    var title: String
    var notification: [Notification]
}


struct Notification {
    var title: String
    var detail: String
}


extension NotificationCategory {
    
    static var allNotifications: [NotificationCategory] {
        return [
            NotificationCategory(title: "Срочное", notification: [
                
            Notification(title: "Отправить приглашение на практику в деканат",
                   detail: "отсканируйте и прикрепите"),
            Notification(title: "Регистрация на осенний семестр уже начался",
                   detail: "продлится до 1 мая"),
            Notification(title: "Сдать отчет по преддипломной практике",
                   detail: "прикрепите электронную версию здесь"),
            Notification(title: "Заберите свои транспортные карты ОНАЙ",
            detail: "забрать с кабинета 201")
            ]),
            
            
            
            NotificationCategory(title: "Не срочное", notification: [
                
            Notification(title: "Выставка ИТ компании в круглом зале",
                   detail: "будет выступать Фуад бей"),
            Notification(title: "Ярмарка вакансии",
                   detail: "онлайн в тимсе в 17:00")
            ])
        ]
        
        
    }
}
