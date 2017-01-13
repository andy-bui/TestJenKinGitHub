//
//  SingleItemCellDataSource.swift
//  Health App
//
//  Created by Cong Phu on 12/28/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
class SingleItemCellModel: InputDataCellModel {
    
    override func validate() -> Bool {
        if required && (content == nil || content!.isEmpty) {
            return false
        }
        
        guard let pattern = validateRegexPattern, let content = content else {
            return true
        }
        return Date.dateFromString(dateString: content, format: pattern) != nil
    }
}
