//
//  SegmentedCellModel.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/23/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation


typealias ValueChangedClosure = (_ value: Int) -> ()

class SegmentedCellModel: InputDataCellModel {
    var value: Int = 0
    var segmentedTitles:[String]?
    var valueChangedClosure: ValueChangedClosure?
}
