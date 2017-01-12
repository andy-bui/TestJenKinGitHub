//
//  ReminderSettingDataSource.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import OneSignal

struct ReminderAction {
    static let reminderTimeAction = BaseDataSourceAction(withName: AppConfig.Nibs.segmentedCell)
}
class ReminderSettingDataSource: BaseDataSource {
    override func initialData() -> [BaseDataSourceSection] {

        var firstModel: [BaseCellModel] = []
        var secondModel: [BaseCellModel] = []
        
        let notificationTimeCell = SingleItemCellModel(withTitle: "時間", accessoryType: .disclosureIndicator, nibName: AppConfig.Nibs.singleItemContentCell)
        notificationTimeCell.required = false
        notificationTimeCell.content = UserDefaults.timeReminder.timeToString()
        notificationTimeCell.cellAction = ReminderAction.reminderTimeAction
        firstModel.append(notificationTimeCell)
        
        let notificationControl = SegmentedCellModel(withTitle: "BROOKSのお知らせ通知", nibName: AppConfig.Nibs.segmentedCell)
        notificationControl.segmentedTitles = ["ON", "OFF"]
        notificationControl.value = UserDefaults.notification == true ? 0 : 1
        notificationControl.valueChangedClosure = { value in
            UserDefaults.notification = (value == 0)
            OneSignal.setSubscription(UserDefaults.notification)
        }
        secondModel.append(notificationControl)
        return [BaseDataSourceSection(withCellModels: firstModel), BaseDataSourceSection(withCellModels: secondModel)]
    }
    
    override func selectRow(_ row: Int, inSection section: Int) {
        guard let cellAction = action(forRow: row, inSection: section) else {
            return
        }
        delegate?.didSelectAction(cellAction)
    }
}
