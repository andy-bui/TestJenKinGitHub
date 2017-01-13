//
//  BasicDataSettingViewController.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class BasicDataSettingViewController: BaseTableViewController {
    override func viewDidLoad() {
        tableViewDataSource = BasicDataSettingDataSource()
        super.viewDidLoad()
    }
    
    override func didSelectAction(_ action: BaseDataSourceAction) {
        weak var weakSelf = self
        switch action {
        case DataSettingsAction.BirthDay:
            self.showDatePicker(actionCallback: { (date) in
                if  let cellModel = weakSelf!.tableViewDataSource?.cellModel(forRow: 1, inSection: 0) {
                    cellModel.content = date.toString()
                    let realm = try! Realm()
                    try! realm.write {
                        guard let userInfo = UserDataManager.sharedInstance.currentUser else {
                            return
                        }
                        userInfo.birthday = date
                    }
                    weakSelf!.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0) ], with: .none)
                }
            }, fromDate: nil, toDate: Date(), selectedDate: UserDataManager.sharedInstance.currentUser?.birthday)
        default:
            break
        }
    }
    
    override func showDialog() {
        guard let momentumView = Bundle.main.loadNibNamed(AppConfig.Nibs.momentumView, owner: self, options: nil)?.first as? BaseDialogView else {
            return
        }
        var frame = momentumView.frame
        let screenBounds = UIScreen.main.bounds
        frame.size.height = 0.8 * screenBounds.height
        frame.size.width = 0.9 * screenBounds.width
        momentumView.frame = frame
        self.showDialog(view: momentumView, isTitle: true, title: nil)
    }

}
