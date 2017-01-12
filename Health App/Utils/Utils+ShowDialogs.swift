//
//  Utils+ShowDialogs.swift
//  Health App
//
//  Created by Nhoc Con on 12/28/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

extension Utils {
    static func showDialogTargetWeightSetting (viewController : UIViewController, action: @escaping ()->Void){
        let v = Bundle.main.loadNibNamed("TargetWeightSettingDialog", owner: viewController, options: nil)?.first as! TargetWeightSettingDialog
        v.initDialog(complete: action)
        viewController.showDialog(view: v, isTitle: true, title: "目標体重再設定")
    }
    static func showDialogTargetAchievement (viewController : UIViewController, action: @escaping ()->Void, type : EnumTargetType, targetValue : String, title : String){
        let v = Bundle.main.loadNibNamed("TargetDialog", owner: viewController, options: nil)?.first as! TargetDialog
        v.initDialog(type: type, targetString: targetValue, complete: action)
        viewController.showDialog(view: v, isTitle: true, title: title)
    }
    static func showDialogCalorieSavingSetting (viewController : UIViewController, valueCalorie : String){
        let v = Bundle.main.loadNibNamed("CalorieSavingSettingDialog", owner: viewController, options: nil)?.first as! CalorieSavingSettingDialog
        v.setCalorieValue(value: valueCalorie)
        viewController.showDialog(view: v, isTitle: true, title: nil)
    }
    static func showDialogSelectBikokusai (viewController : UIViewController, actionDone : @escaping (BikokusaiType, String) -> Void){
        let v = Bundle.main.loadNibNamed("SelectBikokusaiDialog", owner: viewController, options: nil)?.first as! SelectBikokusaiDialog
        v.initDialog (complete: actionDone)
        viewController.showDialog(view: v, isTitle: true, title: nil)
    }
    static func showDialogAddNewMeal (viewController : UIViewController, actionDone : @escaping (AddMealType) -> Void){
        let v = Bundle.main.loadNibNamed(AppConfig.Nibs.addNewMealDialog, owner: viewController, options: nil)?.first as! AddNewMealDialog
        v.initDialog (complete: actionDone)
        viewController.showDialog(view: v, isTitle: true, title: nil)
    }
}
