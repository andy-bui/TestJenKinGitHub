//
//  SettingsDataSource.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

struct SettingsAction {
    static let BasicData         = BaseDataSourceAction(withName: "BasicData")
    static let BikokusaiSettings = BaseDataSourceAction(withName: "BikokusaiSettings")
    static let Notifications     = BaseDataSourceAction(withName: "Notifications")
    static let About             = BaseDataSourceAction(withName: "About")
    static let Help              = BaseDataSourceAction(withName: "Help")
}

class SettingsDataSource: BaseDataSource {
    override func initialData() -> [BaseDataSourceSection] {
        var cellModels: [BaseCellModel] = []
        
        cellModels.append(BaseCellModel(withTitle: "基本データ", accessoryType: .disclosureIndicator, nibName: AppConfig.Nibs.singleItemCell , cellAction: SettingsAction.BasicData))
        cellModels.append(BaseCellModel(withTitle: "美穀菜生活", accessoryType: .disclosureIndicator, nibName: AppConfig.Nibs.singleItemCell, cellAction: SettingsAction.BikokusaiSettings))
        cellModels.append(BaseCellModel(withTitle: "通知設定", accessoryType: .disclosureIndicator, nibName: AppConfig.Nibs.singleItemCell, cellAction: SettingsAction.Notifications))
        cellModels.append(BaseCellModel(withTitle: "美穀菜アプリについて", accessoryType: .disclosureIndicator, nibName: AppConfig.Nibs.singleItemCell, cellAction: SettingsAction.About))
        cellModels.append(BaseCellModel(withTitle: "ベルプ", accessoryType: .disclosureIndicator, nibName: AppConfig.Nibs.singleItemCell, cellAction: SettingsAction.Help))
        
        return [BaseDataSourceSection(withCellModels: cellModels)]
    }
    
    override func selectRow(_ row: Int, inSection section: Int) {
        guard let cellAction = action(forRow: row, inSection: section) else {
            return
        }
        delegate?.didSelectAction(cellAction)
    }

}
