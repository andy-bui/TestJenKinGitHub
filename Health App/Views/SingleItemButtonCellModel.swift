//
//  SingleItemButtonCellModel.swift
//  Health App
//
//  Created by Nguyen Chi Thanh on 1/3/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation

typealias ResetClosure = () -> ()

class SingleItemButtonCellModel: BaseCellModel {
    var valueChangedClosure: ResetClosure?
}
