//
//  String+HelperMethod.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/23/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
