//
//  AddNewMealDialog.swift
//  Health App
//
//  Created by Nhoc Con on 1/3/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class AddNewMealDialog : BaseDialogView{
    var actionDone : ((AddMealType) -> Void)?
    var type : AddMealType = AddMealType.none
    func doActionDone() {
        if let action = actionDone{
            action(type)
            hideDialog()
        }
    }
    
    @IBAction func didTapBtnSnack(_ sender: Any) {
        type = AddMealType.snack
        doActionDone()
    }
    @IBAction func didTapBtnMidnightSnack(_ sender: Any) {
        type = AddMealType.midNightSnack
        doActionDone()
    }
    @IBAction func didTapBtnOtherMeal(_ sender: Any) {
        type = AddMealType.otherMeal
        doActionDone()
    }
    
    func initDialog(complete: ((AddMealType) -> Void)?) {
        actionDone = complete
    }
}
enum AddMealType : Int {
    case none = -1
    case snack = 0
    case midNightSnack = 1
    case otherMeal = 2
}
