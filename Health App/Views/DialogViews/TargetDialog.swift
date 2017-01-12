//
//  TargetDialog.swift
//  Health App
//
//  Created by Nhoc Con on 12/27/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

typealias actionDoneTargetDialog = () -> Void
class TargetDialog : BaseDialogView {
    @IBOutlet weak var contentLine1: UILabel!
    @IBOutlet weak var contentLine2: UILabel!
    @IBOutlet weak var buttonOk: UIButton!
    @IBOutlet weak var image: UIImageView!
    var actionDone : actionDoneTargetDialog?
    
    @IBAction func didTapOnOkButton(_ sender: Any) {
        if let actionDone = self.actionDone {
            actionDone()
            hideDialog()
        }
    }
    func initDialog(type : EnumTargetType, targetString : String, complete : @escaping actionDoneTargetDialog) {
        actionDone = complete
        // set line 1
        let c1 = "目標の目 "
        let c3 = " が達成kcしalました!"
        let att1 = NSMutableAttributedString(string: c1)
        let att2 = NSAttributedString(string: targetString, attributes: [NSForegroundColorAttributeName : UIColor.red, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)])
        let att3 = NSAttributedString(string: c3)
        att1.append(att2)
        att1.append(att3)
        contentLine1.attributedText = att1
        
        // set line 2
        contentLine2.text = "この調子で引き続き頑張りましょう!"
        
        // set button
        if type == EnumTargetType.weight {
            image.image = UIImage(named: "congratulation_weight")
            buttonOk.setTitle("目標体重を再設定", for: .normal)
        }else if type == EnumTargetType.calorie {
            image.image = UIImage(named: "congratulation_calorie")
            buttonOk.setTitle("カロリー貯金をリセット", for: .normal)
        }
    }
}
enum EnumTargetType {
    case weight
    case calorie
}
