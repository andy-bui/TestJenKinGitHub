//
//  AboutDataSource.swift
//  Health App
//
//  Created by Nguyen Chi Thanh on 12/27/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class AboutDataSource: BaseDataSource {
    override func initialData() -> [BaseDataSourceSection] {
        var cellModels: [BaseCellModel] = []
        let currentVersionCell = SingleItemCellModel(withTitle: "現在のバージョン", nibName: AppConfig.Nibs.singleItemContentCell)
        currentVersionCell.content = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        cellModels.append(currentVersionCell)
        
        return [BaseDataSourceSection(withCellModels: cellModels)]
    }
    
    override func selectRow(_ row: Int, inSection section: Int) {
        guard let cellAction = action(forRow: row, inSection: section) else {
            return
        }
        delegate?.didSelectAction(cellAction)
    }
}
