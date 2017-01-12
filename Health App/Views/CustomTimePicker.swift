//
//  CustomTimePicker.swift
//  Health App
//
//  Created by Nguyen Chi Thanh on 1/4/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import UIKit
import Foundation
protocol TimePickerDelegate {
    func getValueFromPicker(timeValue: Date?)
}
class CustomTimePicker: UIView {
    
    var delegate: TimePickerDelegate?
    var picker: UIDatePicker!
    var timeValue: Date?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        picker = UIDatePicker(frame: CGRect(origin: CGPoint(x: 0, y: frame.height*2/3 - 49), size: CGSize(width: frame.width, height: frame.height/3)))
        picker.datePickerMode = .time
        picker.timeZone = TimeZone(identifier: "UTC")
        picker.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        picker.backgroundColor = UIColor.white
        addSubview(picker)
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapToHide))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tapToHide() {
        UIView.animate(withDuration: 0.3) { 
            self.isHidden = true
        }
    }
    
    func changeValue() {
        var cal: Calendar = Calendar.current
        cal.timeZone = TimeZone(identifier: "UTC")!
        let time = cal.dateComponents([.hour, .minute], from: picker.date)
        let timeRemender: Date = cal.date(bySettingHour: time.hour!, minute: time.minute!, second: 0, of: picker.date)!
        
        timeValue = timeRemender
        delegate?.getValueFromPicker(timeValue: timeValue)
    }

}
