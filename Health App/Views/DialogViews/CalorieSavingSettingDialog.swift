
//
//  CalorieSavingSettingDialog.swift
//  Health App
//
//  Created by Nhoc Con on 1/3/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class CalorieSavingSettingDialog: BaseDialogView {
    @IBOutlet weak var calorie: UILabel!
    func setCalorieValue (value : String){
        calorie.text = value
    }
}
