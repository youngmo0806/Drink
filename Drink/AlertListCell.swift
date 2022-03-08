//
//  AlertListCell.swift
//  Drink
//
//  Created by youngmo on 2022/03/04.
//

import UIKit
import UserNotifications

class AlertListCell: UITableViewCell {
    @IBOutlet weak var meridiemLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alertSwitch: UISwitch!

    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func alertSwichValueChange(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              var alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return }
        
        alerts[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alerts), forKey: "alerts")
        
        
        if sender.isOn {
            //스위치가 켜졌을경우 로컬알림 추가
            print("1.신규 알람을 추가 합니다")
            print("2.추가할 알람을 확인합니다. \(alerts[sender.tag])")

            self.userNotificationCenter.addNotificationRequest(by: alerts[sender.tag])
        } else {
            //스위치가 꺼졌을경우 로컬알림 삭제
            self.userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[sender.tag].id])
        }
    }
}
