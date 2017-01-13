//
//  Utils.swift
//  Health App
//
//  Created by Nhoc Con on 12/27/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func tableViewCreateHeaderTitleView(tableView : UITableView, heightHeader : CGFloat = 60, title : String = "") -> UIView {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: heightHeader))
        v.backgroundColor = AppConfig.Colors.tableViewHeaderColor
        
        let lbTitle = UILabel()
        lbTitle.text = title
        lbTitle.font = UIFont.boldSystemFont(ofSize: 18)
        lbTitle.frame = CGRect(x: 10, y: 0, width: v.frame.width, height: v.frame.height)
        
        v.addSubview(lbTitle)
        
        return v
    }
}
