//
//  HealthDatePickerView.swift
//  InfiniHealth_Temp
//
//  Created by Nhoc Con on 12/22/16.
//  Copyright © 2016 Nhoc Con. All rights reserved.
//

import Foundation
import UIKit

class HealthDatePickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var view: UIView!
    @IBOutlet weak var picker: UIPickerView!
    
    var fromDate : Date = Date()
    var toDate : Date = Date()
    let wComponent = 100
    let hComponent = 35
    var dataPicker : (year: [String], month: [String], day: [String]) = (year: [""], month: [], day: [])
    typealias actionCallback = () -> Void
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view = Bundle.main.loadNibNamed("HealthDatePickerView", owner: self, options: nil)?.first as! UIView
        self.addSubview(view)
        
        picker.delegate = self
        picker.dataSource = self
        
        initDefaultComponent()
        initRangeDate()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.view.frame = self.bounds
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initDefaultComponent(){
        dataPicker.day.removeAll()
        dataPicker.month.removeAll()
        // day
        for i in 1..<32 {
            dataPicker.day.append("\(i)")
        }
        // month
        for i in 1..<13 {
            dataPicker.month.append("\(i)")
        }
    }
    func initRangeDate() {
        let fDate = Date.dateFromString(dateString: "1950/01/01", format: AppConfig.formatDate)
        let tDate = Date.dateFromString(dateString: "2030/01/01", format: AppConfig.formatDate)
        initRangeDate(from: fDate!, to: tDate!)
    }
    func initRangeDate(from: Date?, to: Date?) {
        fromDate = from == nil ? fromDate : from!
        toDate = to == nil ? toDate : to!
        
        dataPicker.year.removeAll()
        
        let fDate = fromDate.getDateValues()
        let tDate = toDate.getDateValues()
        
        // year
        for i in fDate.year..<tDate.year + 1 {
            dataPicker.year.append("\(i)")
        }
        
        picker.reloadComponent(0)
        setPickerValue(date: Date())
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var arr : [String] = []
        if component == 0 {
            arr = dataPicker.year
        }
        else if component == 1 {
            arr = dataPicker.month
        }else {
            arr = dataPicker.day
        }
        
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.text = arr[row]
        pickerLabel.font = UIFont.systemFont(ofSize: 25)
        pickerLabel.backgroundColor = UIColor.clear
        pickerLabel.frame = CGRect(x: 0, y: 0, width: wComponent, height: hComponent)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0
        {
            return dataPicker.year.count
        }
        else if component == 2
        {
            return dataPicker.day.count
        }
        return dataPicker.month.count
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(wComponent)
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(hComponent)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 || component == 0 {
            dataPicker.day.removeAll()
            let month = Int(dataPicker.month[picker.selectedRow(inComponent: 1)])
            let year = Int(dataPicker.year[picker.selectedRow(inComponent: 0)])
            let num = Date.numberOfDays(month: month!, year: year!)
            for i in 1..<num + 1 {
                dataPicker.day.append("\(i)")
            }
            picker.reloadComponent(2)
        }
        checkValidDate()
    }
    
    func setPickerValue(day : Int, month : Int, year : Int) {
        picker.selectRow(day-1, inComponent: 2, animated: true)
        picker.selectRow(month-1, inComponent: 1, animated: true)
        let i = dataPicker.year.index(of: String(year))
        picker.selectRow(i ?? 0, inComponent: 0, animated: true)
    }
    func setPickerValue(date : Date) {
        let arr = date.getDateValues()
        setPickerValue(day: arr.day, month: arr.month, year: arr.year)
    }
    func getPickerValueToDate() -> Date{
        let day = dataPicker.day[(picker.selectedRow(inComponent: 2))]
        let month = dataPicker.month[(picker.selectedRow(inComponent: 1))]
        let year = dataPicker.year[(picker.selectedRow(inComponent: 0))]
        let stringDate = "\(year)/\(month)/\(day)"
        return Date.dateFromString(dateString: stringDate, format: AppConfig.formatDate)!
    }
    func checkValidDate() {
        let date = getPickerValueToDate()
        let fallsBetween = (fromDate...toDate).contains(date)
        if !fallsBetween {
            let yCurrent = date.getDateValues().year
            let fyCurrent = fromDate.getDateValues().year
            let tyCurrent = toDate.getDateValues().year
            let c1 = abs(yCurrent - fyCurrent)
            let c2 = abs(yCurrent - tyCurrent)
            if c1 < c2 {
                setPickerValue(date: fromDate)
            }else{
                setPickerValue(date: toDate)
            }
        }
    }
}
