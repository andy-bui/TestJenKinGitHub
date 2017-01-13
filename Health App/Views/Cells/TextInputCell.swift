//
//  TextInputCell.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/23/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class TextInputCell: InputDataCell {

    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var itemSubLabel: UILabel?
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var itemIcon: UIImageView!
 
    
    
    override func configure(_ cellModel: BaseCellModel) {
        
        guard let cellModel = cellModel as? TextInputCellModel else {
            fatalError("Invalid CellModel, should be InputCellModel")
        }
        
        super.configure(cellModel)
        self.itemLabel.text = cellModel.title
        if let subTitle = cellModel.secondTitle {
            self.itemSubLabel?.text = subTitle
        }
        
        if let content = cellModel.content {
            self.textField.text = content
        }
 
        if let iconName = cellModel.iconName, let icon = UIImage.init(named: iconName) {
            self.itemIcon.image = icon
        }
        
        self.textField.addTarget(self, action: #selector(TextInputCell.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        self.textField.addTarget(self, action: #selector(TextInputCell.textFieldDidEndEditing(_:)), for: UIControlEvents.editingDidEnd)
        self.textField.addTarget(self, action: #selector(TextInputCell.textFieldDidBeginEditing(_:)), for: UIControlEvents.editingDidBegin)
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        guard let cellModel = self.cellModel as? TextInputCellModel else {
            return
        }
        
        self.cellModel?.content = textField.text?.trim()
        
        if let textChanged = cellModel.textChangedClosure {
            textChanged(textField.text ?? "")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.cellModel?.content = textField.text?.trim()
        if textField.isKind(of: FloatTextField.self) {
            if let content = self.cellModel?.content, let num = Float(content) {
                self.textField.text = num.formatToString(.none)
            }else {
                self.textField.text = "0"
            }
            self.cellModel?.content = self.textField.text

        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.textField.text = textField.text?.trim()
        
        if textField.isKind(of: FloatTextField.self) && self.textField.text == "0" {
            self.textField.text = ""
        }
    }

}
