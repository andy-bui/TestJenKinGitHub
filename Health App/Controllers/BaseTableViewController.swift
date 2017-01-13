//
//  BaseTableViewController.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BaseDataSourceDelegate {

    @IBOutlet var tableView: UITableView!
    var tableViewDataSource: BaseDataSource?
    var footerText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppConfig.Colors.mainColorBackground
        self.tableView.backgroundColor = AppConfig.Colors.tableViewBackgroundColor
        let tableFooterView = UIView()
        tableFooterView.backgroundColor = .clear
        self.tableView.tableFooterView = tableFooterView
        if let footerText = self.footerText {
            tableFooterView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
            let textLb = UILabel(frame: CGRect(x: 15, y: 0, width: tableFooterView.frame.width - 30, height: 44))
            textLb.text = footerText
            textLb.adjustsFontSizeToFitWidth = true
            textLb.textAlignment = .left
            textLb.textRect(forBounds: textLb.frame, limitedToNumberOfLines: 1)
            textLb.textColor = UIColor.darkGray
            tableFooterView.addSubview(textLb)
        }
        
        tableViewDataSource?.tableView = self.tableView
        tableViewDataSource?.delegate = self
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewDataSource = tableViewDataSource else {
            fatalError("Missing datasource!")
        }
        do {
            return try tableViewDataSource.cellForRow(indexPath.row, inSection: indexPath.section)
        } catch DataSourceError.noTableView {
            fatalError("DataSource has no TableView!")
        } catch DataSourceError.noCell(let identifier) {
            fatalError("No cell with identifier '" + identifier + "'")
        } catch {
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableViewDataSource?.selectRow(indexPath.row, inSection: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewDataSource?.heightForRow(indexPath.row, inSection: indexPath.section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewDataSource?.estimatedHeightForRow(indexPath.row, inSection: indexPath.section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewDataSource?.titleForHeader(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewDataSource?.viewForHeader(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewDataSource?.heightForHeader(inSection: section) ?? 44.0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return tableViewDataSource?.titleForFooter(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableViewDataSource?.heightForFooter(inSection: section) ?? 0.0
    }
    
    // MARK: DataSourceDelegate
    
    func didSelectAction(_ action: BaseDataSourceAction) {
        
    }
    
    func insertRow(at row: Int, inSection section: Int) {
        self.tableView.insertRows(at: [IndexPath(row: row, section: section)], with: .none)
    }
    
    internal func didValidateData(_ valid: Bool) {
        
    }
    func showDialog() {
        
    }
}
