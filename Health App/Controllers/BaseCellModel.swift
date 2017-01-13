//
//  BaseCellModels.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class BaseCellModel {
    
    enum SingleItemCellStyle {
        case active
        case inactive
    }
    
    let estimatedHeight = 44.0
    
    var topSeparatorStyle: SeparatorStyle
    var bottomSeparatorStyle: SeparatorStyle
    var accessoryType: UITableViewCellAccessoryType
    
    var icon: UIImage?
    var title: String
    var style: SingleItemCellStyle
    var nibName: String
    var cellAction: BaseDataSourceAction?
    var content: String?
    var secondTitle: String?
    var thirdTitle: String?
    var isOn: Bool?
    
    init(withTitle title: String, secondTitle: String? = nil, thirdTitle: String? = nil, content: String? = nil, icon: UIImage? = nil, topSeparatorStyle: SeparatorStyle = .none, bottomSeparatorStyle: SeparatorStyle = .full, accessoryType: UITableViewCellAccessoryType = .none, cellStyle: SingleItemCellStyle = .active, nibName: String, cellAction: BaseDataSourceAction? = nil, isOn : Bool = false) {
        self.title = title
        self.secondTitle = secondTitle
        self.thirdTitle = thirdTitle
        self.content = content
        self.icon = icon
        self.topSeparatorStyle = topSeparatorStyle
        self.bottomSeparatorStyle = bottomSeparatorStyle
        self.accessoryType = accessoryType
        self.style = cellStyle
        self.nibName = nibName
        self.cellAction = cellAction
        self.isOn = isOn
    }
}

