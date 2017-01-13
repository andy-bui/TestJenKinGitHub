//
//  TextInputCellModel.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/23/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation

typealias TextChangedClosure = (_ value: String) -> ()

class TextInputCellModel: InputDataCellModel {
    
    var iconName: String?
    var textChangedClosure: TextChangedClosure?
    
    override func validate() -> Bool {
        if required && (content == nil || content!.isEmpty) {
            return false
        }
        
        guard let pattern = validateRegexPattern, let content = content else {
            return true
        }
        
        return Regex(pattern: pattern).match(content)
    }
}
