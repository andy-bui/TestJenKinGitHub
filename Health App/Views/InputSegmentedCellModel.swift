//
//  InputSegmentedCellModel.swift
//  Health App
//
//  Created by Cong Phu on 1/6/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation

typealias ShowActivityInfoClosure = ()->()

class InputSegmentedCellModel: SegmentedCellModel {
    
    var showActivityInfoClosure: ShowActivityInfoClosure?
}
