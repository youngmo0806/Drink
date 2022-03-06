//
//  Alert.swift
//  Drink
//
//  Created by youngmo on 2022/03/04.
//

import UIKit

struct Alert: Codable {
    var id: String = UUID().uuidString
    let date: Date
    var isOn: Bool
    
    var time: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var meridiem: String {
        let meridiemFormatter = DateFormatter()
        meridiemFormatter.dateFormat = "a"  //오전인지 오후인지
        meridiemFormatter.locale = Locale(identifier: "ko") //한국의 시간
        return meridiemFormatter.string(from: date)
    }
}
