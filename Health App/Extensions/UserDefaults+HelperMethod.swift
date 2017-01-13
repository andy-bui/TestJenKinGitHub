//
//  UserDefaults+HelperMethod.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation

extension UserDefaults {
    static func setWelcomeFirstClick(_ firstClick: Bool = false) {
        UserDefaults.standard.setValue(firstClick, forKey: AppConfig.Keys.USER_FIRST_CLICK)
    }
    
    static func getWelcomeFirstClick() -> Bool {
        guard let firstClick = UserDefaults.standard.value(forKey: AppConfig.Keys.USER_FIRST_CLICK) as? Bool else {
            return false
        }
        
        return firstClick
    }
    
    static var startingDayBikokusai: Date? {
        get {
            guard let returnValue = UserDefaults.standard.value(forKey: AppConfig.Keys.kStartingDayBikokusai) as? Date else {
                return nil
            }
            return returnValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppConfig.Keys.kStartingDayBikokusai)
        }
    }

    static var bikokusaiMode: Bool {
        get {
            guard let returnValue = UserDefaults.standard.value(forKey: AppConfig.Keys.kBikokusaiMode) as? Bool else {
                return false
            }
            return returnValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppConfig.Keys.kBikokusaiMode)
        }
    }
    
    static var bikokusaiDesign: Bool {
        get {
            guard let returnValue = UserDefaults.standard.value(forKey: AppConfig.Keys.kBikokusaiDesign) as? Bool else {
                return false
            }
            return returnValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppConfig.Keys.kBikokusaiDesign)
        }
    }
    
    static var bikokusaiProduct: String {
        get {
            guard let returnValue = UserDefaults.standard.value(forKey: AppConfig.Keys.kBikokusaiProduct) as? String else {
                return ""
            }
            return returnValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppConfig.Keys.kBikokusaiProduct)
        }
    }
    
    static var timeReminder: Date {
        get {
            guard let returnValue = UserDefaults.standard.value(forKey: AppConfig.Keys.kTimeRemender) as? Date else {
                let date: Date = Date()
                var cal: Calendar = Calendar.current
                cal.timeZone = TimeZone(identifier: "UTC")!
                let timeDefault: Date = cal.date(bySettingHour: 8, minute: 00, second: 0, of: date)!
                return timeDefault
            }
            return returnValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppConfig.Keys.kTimeRemender)
        }
    }
    
    static var notification: Bool {
        get {
            guard let returnValue = UserDefaults.standard.value(forKey: AppConfig.Keys.kNotification) as? Bool else {
                return true
            }
            return returnValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppConfig.Keys.kNotification)
        }
    }
    
}
