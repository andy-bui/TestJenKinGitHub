//
//  HowToDrinkDataSource.swift
//  Health App
//
//  Created by Nhoc Con on 1/3/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

struct HowToDrinkDataAction {
    static let action         = BaseDataSourceAction(withName: "HowToDrinkDataAction")
}
class HowToDrinkDataSource : BaseDataSource{
    let heightForHeader : CGFloat = 50
    
    override func initialData() -> [BaseDataSourceSection] {
        let meal_1 = RadioCellModel(withTitle: "美穀菜 + 水", secondTitle: "50", nibName: "RadioCell", cellAction: HowToDrinkDataAction.action, isOn: false)
        let meal_2 = RadioCellModel(withTitle: "美穀菜 + 牛乳", secondTitle: "190", nibName: "RadioCell", cellAction: HowToDrinkDataAction.action, isOn: false)
        let meal_3 = RadioCellModel(withTitle: "美穀菜 + 低脂肪牛乳", secondTitle: "150", nibName: "RadioCell", cellAction: HowToDrinkDataAction.action, isOn: false)
        let meal_4 = RadioCellModel(withTitle: "美穀菜 + 豆乳", secondTitle: "160", nibName: "RadioCell", cellAction: HowToDrinkDataAction.action, isOn: false)
        let meal_5 = RadioCellModel(withTitle: "美穀菜 + 水と豆乳", secondTitle: "85", nibName: "RadioCell", cellAction: HowToDrinkDataAction.action, isOn: false)
        
        let dataMeal = [meal_1, meal_2, meal_3, meal_4, meal_5]
        let section0 = BaseDataSourceSection.init(withCellModels: dataMeal)
        
        return [section0]   
    }
    
    override func selectRow(_ row: Int, inSection section: Int) {
        guard let cellAction = action(forRow: row, inSection: section) else {
            return
        }
        delegate?.didSelectAction(cellAction)
    }
    
    override func viewForHeader(inSection section: Int) -> UIView? {
        if let table = self.tableView {
            return Utils.tableViewCreateHeaderTitleView(tableView: table, heightHeader: heightForHeader, title: "飲み方を選択してください")
        }
        return nil
    }
    override func heightForHeader(inSection section: Int) -> CGFloat {
        return heightForHeader
    }
}
