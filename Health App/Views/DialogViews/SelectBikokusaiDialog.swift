//
//  SelectBikokusaiDialog.swift
//  Health App
//
//  Created by Nhoc Con on 1/3/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class SelectBikokusaiDialog: BaseDialogView, SSRadioButtonControllerDelegate {
    @IBOutlet weak var btnDone: GreenButton!
    @IBOutlet weak var btnTrial: UIButton!
    @IBOutlet weak var btnBox1: UIButton!
    @IBOutlet weak var btnBox3: UIButton!
    @IBOutlet weak var btnRegularService: UIButton!
    var radioButtonController: SSRadioButtonsController?
    var actionDone : ((BikokusaiType, String) -> Void)?
    
    @IBAction func didTapOnOkButton(_ sender: Any) {
        if let actionDone = self.actionDone {
            var type = -1
            var name = ""
            if let btn = radioButtonController?.selectedButton() {
                type = btn.tag
                name = btn.titleLabel?.text ?? ""
            }
            actionDone(BikokusaiType(rawValue: type)!, name)
            hideDialog()
        }
    }
    func initDialog(complete : @escaping (_ type : BikokusaiType, _ name: String) -> Void) {
        actionDone = complete
        btnTrial.tag = BikokusaiType.trial.rawValue
        btnBox1.tag = BikokusaiType.box1.rawValue
        btnBox3.tag = BikokusaiType.box3.rawValue
        btnRegularService.tag = BikokusaiType.regularService.rawValue
        
        radioButtonController = SSRadioButtonsController(buttons: btnTrial, btnBox1, btnBox3, btnRegularService)
        radioButtonController!.delegate = self
    }
    func didSelectButton(_ aButton: UIButton?) {
        self.btnDone.isEnabled = true
    }
}
enum BikokusaiType : Int{
    case none = -1
    case trial = 0
    case box1 = 1
    case box3 = 2
    case regularService = 3
}

