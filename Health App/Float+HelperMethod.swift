//
//  Float+HelperMethod.swift
//  Health App
//
//  Created by Chuong Vu on 1/9/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation

extension Float{
     func formatToString(_ num:Int = 2) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = num
        return formatter.string(from: NSNumber(value: self))

    }
    func  roundToString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter.string(from: NSNumber(value: Int(roundf(self))))
    }
}

