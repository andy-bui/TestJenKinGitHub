//
//  InputSegmentedCell.swift
//  Health App
//
//  Created by Cong Phu on 1/6/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import UIKit

class InputSegmentedCell: SegmentedCell {

    @IBOutlet weak var btnActivity: GreenButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnActivity.backgroundColor = AppConfig.Colors.activityBtnBgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showActivityInfo(_ sender: Any) {
        guard let cellModel = self.cellModel as? InputSegmentedCellModel else {
            return
        }
        if let closure = cellModel.showActivityInfoClosure {
            closure()
        }
    }

}
