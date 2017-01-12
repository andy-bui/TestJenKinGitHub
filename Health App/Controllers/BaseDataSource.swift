//
//  BaseDataSource.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

enum DataSourceError: Error {
    case noTableView
    case noCell(withIdentifier: String)
}

protocol BaseDataSourceDelegate: class {
    func didSelectAction(_ action: BaseDataSourceAction)
    func insertRow(at row: Int, inSection section: Int)
    func didValidateData(_ valid: Bool)
    func showDialog()
}

struct BaseDataSourceAction {
    let name: String
    var parameters: [String: String]?
    init(withName name: String, parameters: [String: String]? = nil) {
        self.name = name
        self.parameters = parameters
    }
    
    static func ==(first: BaseDataSourceAction, second: BaseDataSourceAction) -> Bool { // swiftlint:disable:this operator_whitespace
        return first.name == second.name
    }
    
    static func ~=(first: BaseDataSourceAction, second: BaseDataSourceAction) -> Bool { // swiftlint:disable:this operator_whitespace
        return first == second
    }
}

struct BaseDataSourceSection {
    var cellModels: [BaseCellModel]
    var title: String?
    init(withCellModels cellModels: [BaseCellModel], title: String? = nil) {
        self.cellModels = cellModels
        self.title = title
    }
}

class BaseDataSource {
    
    weak var delegate: BaseDataSourceDelegate?
    var data: [BaseDataSourceSection] = []
    
    var tableView: UITableView? {
        didSet {
            tableView?.rowHeight = UITableViewAutomaticDimension
            tableView?.estimatedRowHeight = 44
        }
    }
    
    init() {
        data = initialData()
    }
    
    func initialData() -> [BaseDataSourceSection] {
        return []
    }
    
    func cellModel(forRow row: Int, inSection section: Int = 0) -> BaseCellModel {
        return data[section].cellModels[row]
    }
    
    func action(forRow row: Int, inSection section: Int = 0) -> BaseDataSourceAction? {
        return data[section].cellModels[row].cellAction
    }
    
    func cellForRow(_ row: Int, inSection section: Int = 0) throws -> UITableViewCell {
        guard let tableView = tableView else {
            throw DataSourceError.noTableView
        }
        let cellModel = self.cellModel(forRow: row, inSection: section)
        let cellAction = action(forRow: row, inSection: section)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellModel.nibName)
        if cell == nil {
            let nib = UINib.init(nibName: cellModel.nibName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellModel.nibName)
            cell = tableView.dequeueReusableCell(withIdentifier: cellModel.nibName)
        }
        guard let finalCell = cell as? BaseCell else {
            throw DataSourceError.noCell(withIdentifier: cellModel.nibName)
        }
        finalCell.selectionStyle = cellAction == nil ? .none : .default
        finalCell.configure(cellModel)
        
        return finalCell
    }
    
    func heightForRow(_ row: Int, inSection section: Int = 0) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func heightForHeader(inSection section: Int = 0) -> CGFloat {
        return 44
    }
    
    func heightForFooter(inSection section: Int = 0) -> CGFloat {
        return 0.0
    }
    
    func estimatedHeightForRow(_ row: Int, inSection section: Int = 0) -> CGFloat {
        let cellModel = self.cellModel(forRow: row, inSection: section)
        return CGFloat(cellModel.estimatedHeight)
    }
    
    func numberOfSections() -> Int {
        return data.count
    }
    
    func numberOfRows(inSection section: Int = 0) -> Int {
        return data[section].cellModels.count
    }
    
    func titleForHeader(inSection section: Int = 0) -> String? {
        return data[section].title
    }
    
    func titleForFooter(inSection section: Int = 0) -> String? {
        return nil
    }
    
    func viewForHeader(inSection section: Int = 0) -> UIView? {
        let headerView = SeparatorView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        headerView.bottomSeparator = true
        headerView.backgroundColor = AppConfig.Colors.tableViewBackgroundColor
        return headerView
    }
    
    func selectRow(_ row: Int, inSection section: Int = 0) {
        fatalError()
    }
    
    func insertRow(_ cellModel: BaseCellModel, atRow row: Int, inSection section: Int = 0) {
        self.data[section].cellModels.insert(cellModel, at: row)
        self.delegate?.insertRow(at: row, inSection: section)
    }
    
    func insertLastRow(_ cellModel: BaseCellModel, inSection section: Int = 0) {
        self.insertRow(cellModel, atRow: self.data[section].cellModels.count, inSection: section)
    }
    
    func validate() -> Bool {
        for section in self.data {
            for cellModel in section.cellModels {
                if let inputCellModel = cellModel as? InputDataCellModel {
                    if inputCellModel.validate() == false {
                        print("validate false")
                        self.delegate?.didValidateData(false)
                        return false
                    }
                }
            }
        }
        self.delegate?.didValidateData(true)
        return true
    }
}
