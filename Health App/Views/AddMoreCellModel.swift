//
//  AddMoreCellModel.swift
//  Health App
//
//  Created by Cong Phu on 1/3/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation

typealias AddMoreMealAction = () -> Void

class AddMoreCellModel: BaseCellModel {
    var addMoreMeal: AddMoreMealAction?
}
