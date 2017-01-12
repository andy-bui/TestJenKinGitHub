//
//  SettingsViewController.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: BaseTableViewController {
    override func viewDidLoad() {
        self.tableViewDataSource = SettingsDataSource()
        super.viewDidLoad()
    }
    
    // MARK: BaseDataSourceDelegate
    
    override func didSelectAction(_ action: BaseDataSourceAction) {
        switch action {
        case SettingsAction.BasicData:
            performSegue(withIdentifier: "BasicDataSetting", sender: self)
        case SettingsAction.BikokusaiSettings:
            performSegue(withIdentifier: "BikokusaiSetting", sender: self)
        case SettingsAction.Notifications:
            performSegue(withIdentifier: "ReminderSetting", sender: self)
        case SettingsAction.About:
            performSegue(withIdentifier: "About", sender: self)
        case SettingsAction.Help:
            performSegue(withIdentifier: "Help", sender: self)
        default:
            break
        }
    }
}

