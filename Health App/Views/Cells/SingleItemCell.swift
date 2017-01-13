//
//  SingleItemCell.swift
//  myDriver-Driver-V3.0
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class SingleItemCell: InputDataCell {

    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var itemContentLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        itemLabel.textColor = AppConfig.Colors.mainColorDark
        if let contentLabel = self.itemContentLabel {
            contentLabel.textColor = AppConfig.Colors.mainColorDark
        }
    }

    func setStyle(_ style: BaseCellModel.SingleItemCellStyle) {
        switch style {
        case .active:
            itemLabel.textColor = AppConfig.Colors.mainColorDark
        case .inactive:
            itemLabel.textColor = AppConfig.Colors.mainTextColorLight
        }
    }
    
    override func configure(_ cellModel: BaseCellModel) {
        super.configure(cellModel)
        self.setStyle(cellModel.style)
        self.itemLabel.text = cellModel.title
        if let content = cellModel.content {
            self.itemContentLabel?.text = content
        }
        guard let model = cellModel as? SingleItemCellModel else {
            return
        }
        self.itemContentLabel?.textColor = model.required ? UIColor.lightGray : UIColor.black
    }
}
