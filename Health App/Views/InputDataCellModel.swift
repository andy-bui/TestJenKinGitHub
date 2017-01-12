//
//  InputDataModel.swift
//  Health App
//
//  Created by Cong Phu on 12/27/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation

class InputDataCellModel: BaseCellModel {
    var validateRegexPattern: String?
    var required: Bool = false
    func validate() -> Bool {
       return true
    }
}
