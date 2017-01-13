
//
//  BikokusaiSettingViewController.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class BikokusaiSettingViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        self.tableViewDataSource = BikokusaiSettingDataSource()
        self.footerText = "※リセットする場合、カロリー貯金量が0に戻ります。"
        super.viewDidLoad()
    }
    
    override func didSelectAction(_ action: BaseDataSourceAction) {
        weak var weakSelf = self
        switch action {
        case BikokusaiSettingsAction.startingDay:
            guard UserDefaults.bikokusaiMode == true else {
                return
            }
            self.showDatePicker(actionCallback: { (date) in
               (weakSelf?.tableViewDataSource as! BikokusaiSettingDataSource).updateStartingDayCell(date: date)
            }, fromDate: nil, toDate: Date(), selectedDate: UserDefaults.startingDayBikokusai)
        case BikokusaiSettingsAction.selectBikokusaiProduct:
            guard UserDefaults.bikokusaiMode == true else {
                return
            }
            Utils.showDialogSelectBikokusai(viewController: self, actionDone: { (bikokusaiStyle, nameBikokusai) in
                (weakSelf?.tableViewDataSource as! BikokusaiSettingDataSource).updateBikokusaiProductsCell(bikokusaiStyle: bikokusaiStyle, nameBikokusai: nameBikokusai)
            })
        default:
            break
        }
    }
    
    override func showDialog() {
        let alertController = UIAlertController(title: "  ", message: "カロリー貯金が0に戻ります。 よろしいですか?", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default) {
            (result : UIAlertAction) -> Void in
            print("Cancel")
            return
        }
        let okAction = UIAlertAction(title: "はい", style: .default) {
            (result : UIAlertAction) -> Void in
            guard let user = UserDataManager.sharedInstance.currentUser else {
                return
            }
            UserDataManager.sharedInstance.resetUserData(userInfo: user)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)

    }
}

