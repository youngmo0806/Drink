//
//  AlertListViewController.swift
//  Drink
//
//  Created by youngmo on 2022/03/04.
//

import UIKit
import UserNotifications

class AlertListViewController: UITableViewController {
    
    var alerts: [Alert] = []
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "AlertListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AlertListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //화면 표시 될때마다 userDefaults에서 데이터 읽어옴.
        alerts = alertList()
        
        
    }
    
    //신규알람 설정 화면으로 넘어가기
    @IBAction func addAlertButtonAction(_ sender: UIBarButtonItem) {
        
        guard let addAlertVC = storyboard?.instantiateViewController(withIdentifier: "AddAlertViewController") as? AddAlertViewController else { return }
        
        print("process : 3")
        addAlertVC.pickedDate = { [weak self] date in
            guard let self = self else { return }
            print("process : 4")
            var alertList = self.alertList()
            let newAlert = Alert(date: date, isOn: true)
            
            alertList.append(newAlert)
            alertList.sort { $0.date < $1.date }
            
            self.alerts = alertList

            //저장
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            
            
            print("1.신규 알람을 추가 합니다")
            print("2.추가할 알람을 확인합니다. \(newAlert)")
            //신규 등록할때 알람 추가
            self.userNotificationCenter.addNotificationRequest(by: newAlert)
            
            self.tableView.reloadData()
            
        }
        
        self.present(addAlertVC, animated: true, completion: nil)
        
        
        
    }
    
    //데이터 로드
    func alertList() -> [Alert] {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else {return [] }
        
        return alerts
    }
}


//UITableView DataSource, Delegate
extension AlertListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alerts.count
    }
     
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "🚰물마실 시간"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertListCell", for: indexPath) as? AlertListCell else { return UITableViewCell() }
                
        cell.alertSwitch.isOn = alerts[indexPath.row].isOn
        cell.timeLabel.text = alerts[indexPath.row].time
        cell.meridiemLabel.text = alerts[indexPath.row].meridiem
        
        cell.alertSwitch.tag = indexPath.row
        
        return cell
    }
    
    //cell의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //cell 삭제 가능여부 설정
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //cell 삭제 기능 구현
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            print("alerts=> \(alerts)")
            
            //노티피케이션 삭제 구현, 알림 삭제 하기 전에 노티피케이션 먼저 삭제
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[indexPath.row].id])
            
            //알람이 삭제
            self.alerts.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            
            self.tableView.reloadData()
            
            return
        default:
            break
        }
        
    }
}
