//
//  AboutViewController.swift
//  Health App
//
//  Created by Nguyen Chi Thanh on 12/27/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: BaseTableViewController {
    override func viewDidLoad() {
        self.tableViewDataSource = AboutDataSource()
        super.viewDidLoad()
    }
}
