//
//  BikoInputCellModel.swift
//  Health App
//
//  Created by Cong Phu on 1/4/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation

typealias SelectBikoProdductAction = () -> Void

class BikoInputCellModel: TextInputCellModel {
    var isBiko: Bool = false
    var didSelectBikoProduct: SelectBikoProdductAction?
    var bikoItemName: String?
    var bikoItemCalorie: Int = 0
}
