//
//  RadioCell.swift
//  Health App
//
//  Created by Nhoc Con on 1/3/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class RadioCell : BaseCell {
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var kcal: UILabel!
    var valueKcal = ""
    
    func setStatus(isSelected : Bool) {
        if isSelected{
            imgStatus.image = UIImage(named: "selected")
        }else{
            imgStatus.image = UIImage(named: "unselected")
        }
    }
    
    override func configure(_ cellModel: BaseCellModel) {
        super.configure(cellModel)
        guard let model = self.cellModel else {
            return
        }
        self.selectionStyle = .none
        self.name.text = model.title
        self.valueKcal = model.secondTitle ?? "0"
        self.kcal.text = "(\(self.valueKcal) kcal)"
        setStatus(isSelected: model.isOn ?? false)
    }
}
