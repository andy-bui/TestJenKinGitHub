//
//  BikoInputCell.swift
//  Health App
//
//  Created by Cong Phu on 1/4/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import UIKit

class BikoInputCell: TextInputCell {
    
    @IBOutlet weak var bikoInfoView: UIView!
    @IBOutlet weak var normalInfoView: UIView!
    @IBOutlet weak var btnBikoProductSelection: GreenButton!
    @IBOutlet weak var lbBikoProductSelection: UILabel!
    @IBOutlet weak var btnChangeTrailingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnBikoProductSelection.backgroundColor = AppConfig.Colors.mainColorOrange
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configure(_ cellModel: BaseCellModel) {
        guard let cellModel = cellModel as? BikoInputCellModel else {
            fatalError("Invalid CellModel, should be InputCellModel")
        }
        
        super.configure(cellModel)
        if cellModel.isBiko {
            self.btnChangeTrailingConstraint.constant = AppConfig.btnChangeTrailingConstraintShown
        }else {
            self.btnChangeTrailingConstraint.constant = AppConfig.btnChangeTrailingConstraintHidden
        }
        
        self.bikoInfoView.isHidden = !(cellModel.bikoItemCalorie > 0)
        self.normalInfoView.isHidden = cellModel.bikoItemCalorie > 0
        self.lbBikoProductSelection.text = cellModel.bikoItemCalorie > 0 ? AppConfig.Strings.bikoSelectedBtnText : AppConfig.Strings.bikoSelectionBtnText
        self.btnBikoProductSelection.backgroundColor = cellModel.bikoItemCalorie > 0 ? AppConfig.Colors.mainColorGreen : AppConfig.Colors.mainColorOrange

    }
    
    @IBAction func selectBikoProdduct(_ sender: Any) {
        guard let cellModel = self.cellModel as? BikoInputCellModel, let action =  cellModel.didSelectBikoProduct else {
            return
        }
        action()
    }
    
    
}
