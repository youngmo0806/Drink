//
//  AddAlertViewController.swift
//  Drink
//
//  Created by youngmo on 2022/03/04.
//

import UIKit

class AddAlertViewController: UIViewController {
    var pickedDate: ((_ date: Date) -> Void)?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //취소
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //저장
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        print("저장버튼이 눌렸습니다")
        
        print("process : 1")
        self.pickedDate?(datePicker.date)
        
        
        print("알람시간 확인 : \(datePicker.locale)")
        print("알람시간 확인 : \(datePicker.date)")
        print("process : 2")
        
        self.dismiss(animated: true, completion: nil)
        //11 -2
        //18 - 9
    }
    
}
