//
//  HowToDrinkViewController.swift
//  Health App
//
//  Created by Nhoc Con on 1/3/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

typealias DidSelectBikoProduct = (RadioCellModel) -> Void

class HowToDrinkViewController: BaseTableViewController {
    @IBOutlet var btnRecord: UIButton!
    var indexCellSelected: Int? {
        didSet {
            self.btnRecord.isEnabled = self.indexCellSelected != nil
        }
    }
    var selectAction: DidSelectBikoProduct?
    
    override func viewDidLoad() {
        self.navigationItem.title = "美穀菜に変更"
        let rightBarButton = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(HowToDrinkViewController.cancel))
        rightBarButton.tintColor = AppConfig.Colors.mainColorOrange
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.tableViewDataSource = HowToDrinkDataSource()
        self.btnRecord.isEnabled = self.indexCellSelected != nil
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = self.indexCellSelected {
            self.tableViewDataSource?.cellModel(forRow: index).isOn = false
        }
        self.indexCellSelected = indexPath.row
        self.tableViewDataSource?.cellModel(forRow: indexPath.row).isOn = true
        tableView.reloadData()
        
    }
    
 
    @IBAction func done(_ sender: Any) {
        guard let index = self.indexCellSelected, let cellModel =  self.tableViewDataSource?.data.first?.cellModels[index] as? RadioCellModel,
            let action = self.selectAction else {
                return
        }
        action(cellModel)
        self.cancel()
    }
    
    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
