//
//  DataRecordingDataSource.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

protocol DataRecordingDataSourceDelegate: class {
    func didChangeBikoType(type: BikokusaiType)
    func updateBikoInfo(mealInfo: MealInfo, cellModel: BikoInputCellModel)
}

class DataRecordingDataSource: BaseDataSource {
    weak var dataRecordingDelegate:DataRecordingDataSourceDelegate?
    var recommendedCalories: Int = 0
    var currentDate:Date? {
        didSet {
            self.data = self.initialData()
        }
    }
    var bikoType:BikokusaiType = .none {
        didSet {
            self.dataRecordingDelegate?.didChangeBikoType(type: bikoType)
            guard let cellModels = self.data.first?.cellModels else {
                return
            }
            for cellModel in cellModels {
                if let bikoCellModel = cellModel as? BikoInputCellModel {
                    bikoCellModel.isBiko = self.bikoType != .none
                }
                
            }
            self.tableView?.reloadData()
        }
    }
    var totalCalories: Int = 0
    var bodyWeight:Float?
    var bodyFat:Float?
    var meals = [MealInfo]()
    override func initialData() -> [BaseDataSourceSection] {
        self.data.removeAll()
        self.meals.removeAll()
        guard let curDate = self.currentDate else {
            return []
        }
        var cellModels = [BaseCellModel]()
        if let dataRecording = UserDataManager.sharedInstance.getUserDataFromDate(curDate) {
            for meal in dataRecording.meals {
                let mealInfo = MealInfo(meal: meal)
                self.meals.append(mealInfo)
            }
            self.bodyFat = dataRecording.bodyFat
            self.bodyWeight = dataRecording.bodyWeight
            if let type = BikokusaiType(rawValue: dataRecording.bikoType) {
                self.bikoType = type
            }else {
                self.bikoType = .none
            }
        }else {
            self.bodyFat = nil
            self.bodyWeight = nil
            self.meals = MealInfo.createMealsDefault(recommendedCalories: self.recommendedCalories)
            self.bikoType = .none
        }
        weak var weakSelf = self
        for meal in self.meals {
            let cellModel = self.createNewMealModel(meal: meal)
            cellModels.append(cellModel)
        }
        let addMoreCell = AddMoreCellModel(withTitle: "", nibName: AppConfig.Nibs.addMoreCell)
        addMoreCell.addMoreMeal = {
            weakSelf?.delegate?.showDialog()
        }
        cellModels.append(addMoreCell)
        return [BaseDataSourceSection.init(withCellModels: cellModels) ]
        
    }
    
    override func heightForHeader(inSection section: Int) -> CGFloat {
        return 0
    }
    
    override func viewForHeader(inSection section: Int) -> UIView? {
        return nil
    }
    
    override func heightForRow(_ row: Int, inSection section: Int) -> CGFloat {
        return 50
    }
    
    override func selectRow(_ row: Int, inSection section: Int = 0) {
    }
    
    func createNewMealModel(meal: MealInfo) -> BikoInputCellModel {
        weak var weakSelf = self
        let cellModel = BikoInputCellModel(withTitle: meal.name, nibName: AppConfig.Nibs.bikoInputCell)
        cellModel.content = meal.calorie.description
        cellModel.required = true
        cellModel.isBiko = self.bikoType != .none
        cellModel.bikoItemName = meal.bikoItemName
        cellModel.bikoItemCalorie = meal.bikoItemCalorie
        cellModel.textChangedClosure = { text in
            if  let kal = Int(text) {
                meal.calorie = kal
            }else {
                meal.calorie = 0
            }
            _ = weakSelf!.validate()
        }
        cellModel.didSelectBikoProduct = {
            weakSelf!.dataRecordingDelegate?.updateBikoInfo(mealInfo: meal, cellModel: cellModel)
        }
        
        cellModel.secondTitle = AppConfig.Strings.kcal
        cellModel.iconName = meal.name
        return cellModel

    }
    
    func addNewMeal(newMeal: MealInfo) {
        guard let cellModels = self.data.first?.cellModels else {
            return
        }
        let count = cellModels.count
        self.meals.append(newMeal)
        newMeal.calorie = 0
        let cellModel = self.createNewMealModel(meal: newMeal)
        self.insertRow(cellModel, atRow: count - 1)
        _ = self.validate()
    }
    
    func saveData() {
        guard let date = self.currentDate, let bodyWeight = self.bodyWeight, let bodyFat = self.bodyFat else {
            return
        }
        var mealsUpdated = [Meal]()
        for mealInfo in self.meals {
            mealsUpdated.append(Meal(mealInfo: mealInfo))
        }
        
        
        if let dataRecording = UserDataManager.sharedInstance.getUserDataFromDate(date) {
            dataRecording.update(bodyWeight: bodyWeight,
                                 bodyFat: bodyFat,
                                 meals: mealsUpdated,
                                 bikoType: self.bikoType.rawValue,
                                 intake: self.totalCalories)
            
        }else {
            _ = UserDataManager.sharedInstance.createUserDataForDate(bodyWeight,
                                                                 bodyFat: bodyFat,
                                                                 date: date,
                                                                 meals: mealsUpdated,
                                                                 bikoType: self.bikoType.rawValue,
                                                                 intake: self.totalCalories)
        }
        if UserDataManager.sharedInstance.checkLatestDataRecording(date: date) {
            UserDefaults.bikokusaiDesign = self.bikoType != .none
        }
    }
}

