//
//  Date+String.swift
//  Health App
//
//  Created by Cong Phu on 12/21/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation

extension Date {
//    func toString() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = AppConfig.formatDate
//        return dateFormatter.string(from: self)
//    }
    func toString(format: String = AppConfig.formatDate) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "US_en")
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: self)
    }
    
    func birthdayFromAge(age: Int) -> Date? {
        guard let nextDate = Calendar.current.date(byAdding: .year, value: age, to: self) else {
            return nil
        }
        return nextDate
    }
    
    func otherDate(value: Int) -> Date? {
        
        guard let nextDate = Calendar.current.date(byAdding: .day, value: value, to: self) else {
            return nil
        }
        return nextDate
    }
    
    func nextDate() -> Date? {
        return self.otherDate(value: 1)
        
    }
    
    func preDate() -> Date? {
        return self.otherDate(value: -1)
    }
    static func dateFromString(dateString: String, format: String = AppConfig.formatDate) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "US_en")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = format
        let date = formatter.date(from: dateString)
        return date
    }
    func getDateValues() -> ((day: Int, month: Int, year: Int)) {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let units: Set<Calendar.Component> = [.day, .month, .year]
        let components = calendar.dateComponents(units, from: self)
        return ((components.day!, components.month!, components.year!))
    }
    
    // Get max day of month/year
    static func numberOfDays(month : Int, year : Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numberOfDays = range.count
        return numberOfDays
    }
    
    func age() -> Int {
        let ageComponents = Calendar.current.dateComponents([.year], from: self, to: Date())
        return ageComponents.year!
    }
    
    // Formater for only time
    func timeToString(format: String = AppConfig.formatTime ) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: self)
    }
}
