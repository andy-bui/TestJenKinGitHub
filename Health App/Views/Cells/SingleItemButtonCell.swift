//
//  SingleItemButtonCell.swift
//  Health App
//
//  Created by Nguyen Chi Thanh on 1/3/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    func showAlert(title:String, message:String);
}

class SingleItemButtonCell: BaseCell {

    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var button: UIButton!
    override func configure(_ cellModel: BaseCellModel) {
        super.configure(cellModel)
        guard let cellModel = cellModel as? SingleItemButtonCellModel else {
            return
        }
        self.titleLB.text = cellModel.title
        self.button.setTitle(cellModel.content, for: .normal)
    }
    @IBAction func onTap(_ sender: GreenButton) {
        guard let cellModel = self.cellModel as? SingleItemButtonCellModel else {
            return
        }
        if let closure = cellModel.valueChangedClosure {
            closure()
        }
    }
    
}
