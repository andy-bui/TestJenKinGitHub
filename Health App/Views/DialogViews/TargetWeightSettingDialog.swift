//
//  TargetWeightSettingDialog.swift
//  Health App
//
//  Created by Nhoc Con on 12/28/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

class TargetWeightSettingDialog: BaseDialogView {
    var actionDone : actionDoneTargetDialog?

    @IBOutlet weak var tfCalorie: UITextField!
    @IBOutlet weak var buttonOk: UIButton!
    @IBAction func didTapOnOkButton(_ sender: Any) {
        if let action = self.actionDone{
            action()
            hideDialog()
        }
    }
    
    func initDialog(complete : @escaping actionDoneTargetDialog) {
        actionDone = complete
        
        // Button OK
        buttonOk.setTitle("決定", for: .normal)
    }
}
