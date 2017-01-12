//
//  UserInfoDataSource.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

struct UserInfoAction {
    static let birthdaySelection = BaseDataSourceAction(withName: AppConfig.Nibs.singleItemContentCell)
}

class UserInfoDataSource: BaseDataSource {
    var userInfo = UserInfo()
    override func initialData() -> [BaseDataSourceSection] {
        weak var weakSelf = self
        // section 0
        let sexCellModel = SegmentedCellModel(withTitle: "性別", nibName: AppConfig.Nibs.segmentedCell)
        sexCellModel.segmentedTitles = [ "男" ,"女"]
        sexCellModel.required = true
        
        sexCellModel.valueChangedClosure = { value in
            weakSelf!.userInfo.sex = (value == 0)
        }

        
        let birthdayCellModel = SingleItemCellModel(withTitle: "生年月日", nibName: AppConfig.Nibs.singleItemContentCell)
        birthdayCellModel.content = "選択してください"
        birthdayCellModel.required = true
        birthdayCellModel.validateRegexPattern  = AppConfig.formatDate
        birthdayCellModel.cellAction = UserInfoAction.birthdaySelection
        let s0Cells = [sexCellModel, birthdayCellModel]
        let section0 = BaseDataSourceSection.init(withCellModels: s0Cells)
        
        
        // section 1
        let heightCellModel = TextInputCellModel(withTitle: "身長", nibName: AppConfig.Nibs.textInputCell)
        heightCellModel.required = true
        heightCellModel.secondTitle = "cm"
        heightCellModel.textChangedClosure = { text in
            _ = weakSelf!.validate()
            guard let height =  Float(text) else {
                return
            }
            weakSelf!.userInfo.height = height
        }
        
        let weightCellModel = TextInputCellModel(withTitle: "体重", nibName: AppConfig.Nibs.textInputCell)
        weightCellModel.required = true
        weightCellModel.secondTitle = "kg"
        weightCellModel.textChangedClosure = { text in
            _ = weakSelf!.validate()
            guard let weight =  Float(text) else {
                return
            }
            
            weakSelf!.userInfo.weight = weight
        }
        
        
        let fatCellModel = TextInputCellModel(withTitle: "体脂肪", nibName: AppConfig.Nibs.textInputCell)
        fatCellModel.secondTitle = "%"
        fatCellModel.textChangedClosure = { text in
            _ = weakSelf!.validate()
            guard let fat =  Float(text) else {
                weakSelf!.userInfo.bodyFat = -1
                return
            }
            
            weakSelf!.userInfo.bodyFat = fat
        }
        
        let targetWeightCellModel = TextInputCellModel(withTitle: "目標体重", nibName: AppConfig.Nibs.textInputCell)
        targetWeightCellModel.required = true
        targetWeightCellModel.secondTitle = "kg"
        targetWeightCellModel.textChangedClosure = { text in
            _ = weakSelf!.validate()
            guard let targetWeight =  Float(text) else {
                return
            }
            
            weakSelf!.userInfo.targetWeight = targetWeight
        }
        
        let activityCellModel = InputSegmentedCellModel(withTitle: "運動量", nibName: AppConfig.Nibs.inputSegmentedCell)
        activityCellModel.required = true
        activityCellModel.segmentedTitles = ["少", "普", "多"]
        activityCellModel.valueChangedClosure = { value in
            weakSelf!.userInfo.momentum  = value
        }
        
        activityCellModel.showActivityInfoClosure = { Void in
            self.delegate?.showDialog()
        }

        let s1Cells = [heightCellModel, weightCellModel, fatCellModel, targetWeightCellModel, activityCellModel]
        let section1 = BaseDataSourceSection.init(withCellModels: s1Cells)
        
        return [section0, section1]
    }
    
    override func heightForRow(_ row: Int, inSection section: Int) -> CGFloat {
        return 44
    }
    
    
    override func selectRow(_ row: Int, inSection section: Int) {
        guard let cellAction = action(forRow: row, inSection: section) else {
            return
        }
        delegate?.didSelectAction(cellAction)
    }
    
    
}
