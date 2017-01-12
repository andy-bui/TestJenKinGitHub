//
//  ValidatingTextField.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 1/6/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation
import UIKit


class ValidatingTextField: UITextField, UITextFieldDelegate {
    
    var regexPattern: String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
        self.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        return Regex(pattern: regexPattern).match(newText)
    }
}
