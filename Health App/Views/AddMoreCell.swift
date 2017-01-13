//
//  AddMoreCell.swift
//  Health App
//
//  Created by Cong Phu on 1/3/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import UIKit

class AddMoreCell: BaseCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addMoreMeal(_ sender: UIButton) {
        
        guard let model = self.cellModel as? AddMoreCellModel, let addMeal = model.addMoreMeal else {
            return
        }
        addMeal()
    }
    
}
