//
//  InputDataTableViewCell.swift
//  Health App
//
//  Created by Cong Phu on 12/27/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import UIKit

class InputDataCell: BaseCell {

    @IBOutlet weak var lbRequiredInput: UILabel!
    override func configure(_ cellModel: BaseCellModel) {
        super.configure(cellModel)
        guard let model = cellModel as? InputDataCellModel else {
            return
        }
        
        if let label = self.lbRequiredInput {
            label.textColor = AppConfig.Colors.requiredFieldColor
            label.font = AppConfig.Fonts.requiredFieldFontSize
            if model.required {
                label.text = "※必須"
            }else {
                label.text = ""
            }
        }
    }
    
}
