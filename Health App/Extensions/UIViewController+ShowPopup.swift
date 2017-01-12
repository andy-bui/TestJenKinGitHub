//
//  UIViewController+ShowPopup.swift
//  Health App
//
//  Created by Nhoc Con on 12/28/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    // Show Dialog
    func showDialog(view : BaseDialogView, isTitle : Bool = false, title : String? = nil) {
        let v = InfiniDialogViewController(nibName: "InfiniDialogViewController", bundle: nil)
        v.modalPresentationStyle = .overCurrentContext
        
        let objPresent = self.tabBarController != nil ? self.tabBarController : self
        objPresent?.present(v, animated: false, completion: {
            v.addAlertView(viewDialog: view, isTitle: isTitle, title: title)
        })
    }
    
    // Show date picker
    func showDatePicker(actionCallback : @escaping (Date) -> Void, fromDate : Date? = nil, toDate : Date? = nil, selectedDate : Date? = nil) {
        let v = HealthDatePickerViewController(nibName: "HealthDatePickerViewController", bundle: nil)
        v.modalPresentationStyle = .overCurrentContext
        v.action = actionCallback
        
        // PresentVC
        let objPresent = self.tabBarController != nil ? self.tabBarController : self
        objPresent?.present(v, animated: false) {
            if fromDate != nil || toDate != nil {
                v.picker.initRangeDate(from: fromDate, to: toDate)
            }
            if let s = selectedDate {
                v.picker.setPickerValue(date: s)
            }
        }
    }
    
    //Show time picker
    func showTimePicker(actionCallback :  @escaping (Date) -> Void, selectedTime : Date? = nil) {
        let v = TimePickerReminderViewController(nibName: nil, bundle: nil)
        v.modalPresentationStyle = .overCurrentContext
        v.action = actionCallback
        
        // PresentVC
        let objPresent = self.tabBarController != nil ? self.tabBarController : self
        objPresent?.present(v, animated: false) {
            if let s = selectedTime {
                v.picker.setDate(s, animated: true)
            }
        }
    }
}
