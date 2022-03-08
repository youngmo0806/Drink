//
//  UNNotificationCenter.swift
//  Drink
//
//  Created by youngmo on 2022/03/07.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    
    //로컬 알림 리퀘스트
    func addNotificationRequest(by alert: Alert) {
        let content = UNMutableNotificationContent()
        content.title = "물 마실 시간이에요"
        content.body = "세계 보건기구가 권장하는 하루 물 섭취량은 1.5~2리터 입니다."
        content.sound = .default
        content.badge = 1
        print("신규 알람을 추가 합니다.")
        let component = Calendar.current.dateComponents([.hour,.minute], from: alert.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn)
        let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
    }
    
    
}
