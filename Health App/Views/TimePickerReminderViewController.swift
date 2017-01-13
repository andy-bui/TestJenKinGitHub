//
//  TimePickerReminderViewController.swift
//  Health App
//
//  Created by Nguyen Chi Thanh on 1/12/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import UIKit

class TimePickerReminderViewController: UIViewController {
    var action: actionDoneDatePicker?
    var picker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker = UIDatePicker(frame: CGRect(x: 0, y: view.frame.height - 240, width: view.frame.width, height: 240))
        picker.datePickerMode = .time
        picker.backgroundColor = .white
        picker.timeZone = TimeZone(identifier: "UTC")
        view.addSubview(picker)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isOpaque = false
        
        let tapToClose = UITapGestureRecognizer(target: self, action: #selector(self.tapToClose))
        view.addGestureRecognizer(tapToClose)
    }
    
    func tapToClose() {
        if let action = self.action {
            let date = picker.date
            action(date)
        }
        self.dismiss(animated: false, completion: nil)
    }
}
