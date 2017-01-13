//
//  BikokusaiSettingDataSource.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

struct BikokusaiSettingsAction {
    static let selectBikokusaiProduct = BaseDataSourceAction(withName: "bikokusaiProduct")
    static let startingDay = BaseDataSourceAction(withName: "startingDay")
}
class BikokusaiSettingDataSource: BaseDataSource {
    override func initialData() -> [BaseDataSourceSection] {
        weak var weakSelf = self
        var firstCellModels: [BaseCellModel] = []
        var secondCellModels: [BaseCellModel] = []
        var thirdCellModels: [BaseCellModel] = []
        
        // First section
        let bikokusaiModeCell = SegmentedCellModel(withTitle: "美穀菜生活", nibName: AppConfig.Nibs.segmentedCell)
        bikokusaiModeCell.segmentedTitles = ["ON", "OFF"]
        bikokusaiModeCell.value = (UserDefaults.bikokusaiMode == true) ? 0 : 1
        bikokusaiModeCell.valueChangedClosure = { value in
            UserDefaults.bikokusaiMode = (value == 0)
            UserDefaults.bikokusaiDesign = (value == 0)
            if let cellModel = weakSelf?.cellModel(forRow: 0, inSection: 1) as? SegmentedCellModel {
                cellModel.value = UserDefaults.bikokusaiDesign ? 1 : 0
                weakSelf?.tableView?.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .none)
            }
            if let cellModel = weakSelf?.cellModel(forRow: 1, inSection: 0) {
                cellModel.content = (UserDefaults.bikokusaiMode == true) ? UserDefaults.bikokusaiProduct : ""
                cellModel.accessoryType = (UserDefaults.bikokusaiMode == true) ? .disclosureIndicator : .none
                weakSelf?.tableView?.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
            }
            if let cellModel = weakSelf?.cellModel(forRow: 2, inSection: 0) {
                cellModel.content = (UserDefaults.bikokusaiMode == true) ? (UserDefaults.startingDayBikokusai?.toString() ?? "") : ""
                cellModel.accessoryType = (UserDefaults.bikokusaiMode == true) ? .disclosureIndicator : .none
                weakSelf?.tableView?.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .none)
            }

        }
        firstCellModels.append(bikokusaiModeCell)
        let bikokusaiProductsCell = SingleItemCellModel(withTitle: "購入セット", nibName: AppConfig.Nibs.singleItemContentCell, cellAction: BikokusaiSettingsAction.selectBikokusaiProduct)
        bikokusaiProductsCell.accessoryType = (UserDefaults.bikokusaiMode == true) ? .disclosureIndicator : .none
        bikokusaiProductsCell.content = (UserDefaults.bikokusaiMode == true) ? UserDefaults.bikokusaiProduct : ""
        bikokusaiProductsCell.required = false
        firstCellModels.append(bikokusaiProductsCell)
        
        let startingDayCell = SingleItemCellModel(withTitle: "購入日付", nibName: AppConfig.Nibs.singleItemContentCell, cellAction: BikokusaiSettingsAction.startingDay)
        startingDayCell.accessoryType = (UserDefaults.bikokusaiMode == true) ? .disclosureIndicator : .none
        startingDayCell.content = (UserDefaults.bikokusaiMode == true) ? (UserDefaults.startingDayBikokusai?.toString() ?? "") : ""
        startingDayCell.required = false
        firstCellModels.append(startingDayCell)
        
        // Second Section
        let appStyleCell = SegmentedCellModel(withTitle: "アプリのスタイル", nibName: AppConfig.Nibs.segmentedCell)
        appStyleCell.segmentedTitles = ["通常", "美穀菜"]
        appStyleCell.value = (UserDefaults.bikokusaiDesign == true) ? 1 : 0
        appStyleCell.valueChangedClosure = { value in
            UserDefaults.bikokusaiDesign = (value == 1)
        }
        secondCellModels.append(appStyleCell)
        
        // Third Section
        let resetCell = SingleItemButtonCellModel(withTitle: "カロリー貯金", content: "リセット", nibName: AppConfig.Nibs.singleItemButtonCell)
        resetCell.valueChangedClosure = { void in
            //reset Calorie savings on home screen caculated
            self.delegate?.showDialog()
        }
        thirdCellModels.append(resetCell)
        
        let firstSection = BaseDataSourceSection(withCellModels: firstCellModels)
        let secondSection = BaseDataSourceSection(withCellModels: secondCellModels)
        let thirdSection = BaseDataSourceSection(withCellModels: thirdCellModels)
        
        return [firstSection, secondSection, thirdSection]
    }
    
    override func selectRow(_ row: Int, inSection section: Int) {
        guard let cellAction = action(forRow: row, inSection: section) else {
            return
        }
        delegate?.didSelectAction(cellAction)
    }
    
    func updateStartingDayCell(date: Date) {
        guard  let cellModel = self.cellModel(forRow: 2, inSection: 0) as? SingleItemCellModel else {
            return
        }
        cellModel.content = date.toString()
        UserDefaults.startingDayBikokusai = date
        tableView?.reloadRows(at: [IndexPath.init(row: 2, section: 0) ], with: .none)
    }
    
    func updateBikokusaiProductsCell(bikokusaiStyle: BikokusaiType, nameBikokusai: String) {
        guard  let cellModel = self.cellModel(forRow: 1, inSection: 0) as? SingleItemCellModel else {
            return
        }
        cellModel.content = nameBikokusai
        UserDefaults.bikokusaiProduct = nameBikokusai
        tableView?.reloadRows(at: [IndexPath.init(row: 1, section: 0) ], with: .none)
    }
}
