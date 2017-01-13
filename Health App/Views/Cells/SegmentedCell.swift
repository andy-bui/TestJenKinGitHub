//
//  ToggleCell.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/23/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit



class SegmentedCell: InputDataCell {
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var itemSubLabel: UILabel?
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    
    override func configure(_ cellModel: BaseCellModel) {
        
        
        guard let cellModel = cellModel as? SegmentedCellModel else {
            fatalError("Invalid CellModel, should be SegmentedCellModel")
        }
        
        super.configure(cellModel)
        self.itemLabel.text = cellModel.title
        if let subTitle = cellModel.secondTitle {
            self.itemSubLabel?.text = subTitle
        }
        self.segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .selected)
        self.segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: .normal)
        if let segmentedTiles = cellModel.segmentedTitles {
            
            self.segmentedControl.removeAllSegments()
            let font = UIFont.systemFont(ofSize: 16)
            self.segmentedControl.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
            for (index, title) in segmentedTiles.enumerated() {
                var segmentWidth = AppConfig.segmentDefaultWidth
                
                if let titleTextAttributes = self.segmentedControl.titleTextAttributes(for: .normal) as? [String : Any] {
                    segmentWidth = title.size(attributes: titleTextAttributes).width
                    segmentWidth += AppConfig.segmentMargin
                }
                
                self.segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
               
                self.segmentedControl.setWidth(segmentWidth, forSegmentAt: index)
            }
            self.segmentedControl.selectedSegmentIndex = cellModel.value
        }
        
    }
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        guard let cellModel = self.cellModel as? SegmentedCellModel else {
            return
        }
        
        cellModel.value = sender.selectedSegmentIndex
        
        if let valueChanged = cellModel.valueChangedClosure {
            valueChanged(sender.selectedSegmentIndex)
        }
    }
}
