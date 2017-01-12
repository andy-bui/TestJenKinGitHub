//
//  BaseCell.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation

protocol BaseCellProtocol {
    var cellModel: BaseCellModel? { get }
    func configure(_ cellModel: BaseCellModel)
}

class BaseCell: SeparatorTableViewCell, BaseCellProtocol{
    
    var cellModel: BaseCellModel?
    
    override func awakeFromNib() {
        tintColor = AppConfig.Colors.mainColorGreen
    }
    
    func configure(_ cellModel: BaseCellModel) {
        self.cellModel = cellModel
        self.configureViewForStyle(topSeparatorStyle: cellModel.topSeparatorStyle, bottomSeparatorStyle: cellModel.bottomSeparatorStyle)
        self.accessoryType = cellModel.accessoryType
    }
}
