//
//  ReminderSettingViewController.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class ReminderSettingViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        self.tableViewDataSource = ReminderSettingDataSource()
        super.viewDidLoad()
    }
    
    override func didSelectAction(_ action: BaseDataSourceAction) {
        if action == ReminderAction.reminderTimeAction {
            print("action")
            weak var weakSelf = self
            self.showTimePicker(actionCallback: { (date) in
                if let reminderDataSource = self.tableViewDataSource as? ReminderSettingDataSource,
                    let cellModel = reminderDataSource.cellModel(forRow: 0) as? SingleItemCellModel {
                    UserDefaults.timeReminder = date
                    cellModel.content = UserDefaults.timeReminder.timeToString()
                    weakSelf?.createLocalNotification(fireTime: date)
                    self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0) ], with: .none)
                    
                }
            }, selectedTime: UserDefaults.timeReminder)
        }
    }
    
    func createLocalNotification(fireTime: Date) {
        if let notifications = UIApplication.shared.scheduledLocalNotifications {
            for notification in notifications {
                UIApplication.shared.cancelLocalNotification(notification)
            }
        }
        let localNotification = UILocalNotification()
        localNotification.timeZone = TimeZone(identifier: "UTC")
        localNotification.repeatInterval = .day
        localNotification.fireDate = fireTime
        localNotification.applicationIconBadgeNumber = 1
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.userInfo = ["Hello": "Don’t forget to input data!!"]
        localNotification.alertBody = "Don’t forget to input data!!"
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
}

