//
//  BasicDataSettingDataSource.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import RealmSwift

struct DataSettingsAction {
    static let BirthDay        = BaseDataSourceAction(withName: "BirthDay")
}

class BasicDataSettingDataSource: BaseDataSource {
    override func initialData() -> [BaseDataSourceSection]  {
        weak var weakSelf = self
        guard let userInfo = UserDataManager.sharedInstance.currentUser else {
            return []
        }
        let realm = try! Realm()
        
        var firstCellModels: [BaseCellModel] = []
        var secondCellModels: [BaseCellModel] = []
        // First Group
        let sexCell = SegmentedCellModel(withTitle: "性別", accessoryType: .none, nibName: AppConfig.Nibs.segmentedCell)
        sexCell.segmentedTitles = ["男", "女"]
        let gender = userInfo.sex
        sexCell.value = gender ? 0 : 1
        sexCell.valueChangedClosure = { value in
            try! realm.write {
                userInfo.sex = value == 0
            }

        }
        firstCellModels.append(sexCell)
        
        let birthDayCell = SingleItemCellModel(withTitle: "生年月日", accessoryType: .disclosureIndicator,  nibName: AppConfig.Nibs.singleItemContentCell, cellAction: DataSettingsAction.BirthDay)
        birthDayCell.content = userInfo.birthday.toString()
        firstCellModels.append(birthDayCell)
        // Second Group
        let heightInputCell = TextInputCellModel(withTitle: "身長", secondTitle: "cm", nibName: AppConfig.Nibs.textInputCell)
        let height = userInfo.height.formatToString()
        heightInputCell.content = height
        heightInputCell.textChangedClosure = { content in
            try! realm.write {
                userInfo.height = Float(content) ?? 0
            }
        }
        secondCellModels.append(heightInputCell)
        
        let weightInputCell = TextInputCellModel(withTitle: "目標体重", secondTitle: "kg", nibName: AppConfig.Nibs.textInputCell)
        let weight = userInfo.weight.formatToString()
        weightInputCell.content = weight
        weightInputCell.textChangedClosure = { content in
            try! realm.write {
                userInfo.weight = Float(content) ?? 0
            }
        }
        secondCellModels.append(weightInputCell)
        
        let activityLevelCell = InputSegmentedCellModel(withTitle: "運動量", secondTitle: "詳細を見る", accessoryType: .none, nibName: AppConfig.Nibs.inputSegmentedCell)
        let momentum = userInfo.momentum
        activityLevelCell.segmentedTitles = ["少", "普", "多"]
        activityLevelCell.value = momentum
        activityLevelCell.valueChangedClosure = { value in
            try! realm.write {
                userInfo.momentum = value
            }
        }
        activityLevelCell.showActivityInfoClosure = { void in
            weakSelf?.delegate?.showDialog()
        }
        secondCellModels.append(activityLevelCell)
        
        let firstSection = BaseDataSourceSection(withCellModels: firstCellModels)
        let secondSection = BaseDataSourceSection(withCellModels: secondCellModels)
        return [firstSection, secondSection]
    }
    
    override func selectRow(_ row: Int, inSection section: Int) {
        guard let cellAction = action(forRow: row, inSection: section) else {
            return
        }
        delegate?.didSelectAction(cellAction)
    }
}
