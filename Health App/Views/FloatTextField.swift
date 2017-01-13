//
//  NumberTextField.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 1/6/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation
import UIKit


class FloatTextField: ValidatingTextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.regexPattern = "^([0-9]{1,5}+)?(\\.([0-9]{1,2})?)?$"
        self.textAlignment = .right
    }
}
