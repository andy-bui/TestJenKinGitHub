//  UserDataManager.swift
//  Health App
//
//  Created by Cong Phu on 12/23/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import RealmSwift

class UserDataManager {
    var currentUser: UserInfo?
    let realm = try! Realm()
    static let sharedInstance: UserDataManager = {
        let instance = UserDataManager()
        return instance
    }()
    init() {
        self.currentUser = realm.objects(UserInfo.self).first
    }
    
    func saveUserInfo(userInfo: UserInfo) {
        guard self.currentUser == nil else {
            return
        }
        do {
            _  = try realm.write {
                realm.add(userInfo, update: true)
                self.currentUser = userInfo
            }
        } catch  {
        }
    }
    
    func createUserDataForDate(_ bodyWeight: Float, bodyFat: Float, date: Date, meals: [Meal]?, bikoType: Int, intake: Int) -> DataRecording? {
        guard let user = self.currentUser else {
            return nil
        }
        let data = DataRecording(user.id, bodyWeight: bodyWeight, bodyFat: bodyFat)
        data.createdDate = date.toString()
        data.bikoType = bikoType
        data.intakeCalories = intake
        do {
            weak var weakSelf = self
            _  = try realm.write {
                
                if let dailyMeals = meals {
                    for meal in dailyMeals {
                        weakSelf!.realm.add(meal, update: true)
                        data.meals.append(meal)
                    }
                }
                weakSelf!.realm.add(data, update: true)
                
            }
        } catch  {
            return nil
        }
        return data
    }
    
    func getUserDataFromDate(_ date: Date) -> DataRecording?{
        guard let user = self.currentUser, let dateStr = date.toString() else {
            return nil
        }
        let predicate = NSPredicate.init(format: "userId = %@ and createdDate = %@", user.id, dateStr)
        return self.realm.objects(DataRecording.self).filter(predicate).first
    }
    
    func updateCurrentUserInfo(userObject: UserObject) {
        guard let user = self.currentUser else {
            return
        }
        
        do {
            _  = try realm.write {
                user.sex = userObject.sex
                user.birthday = userObject.birthday
                user.height = userObject.height
                user.weight = userObject.weight
                user.bodyFat = userObject.bodyFat
                user.targetWeight = userObject.targetWeight
                user.momentum = userObject.momentum
            }
        } catch  {
        }

    }
    func getAllDataRecords() -> Results<DataRecording>?{
        guard let user = self.currentUser else {
            return nil
        }
        let predicate = NSPredicate.init(format: "userId = %@", user.id)
        return self.realm.objects(DataRecording.self).filter(predicate)
    }
    
    func checkLatestDataRecording(date: Date) -> Bool {
        guard let dataRecords = self.getAllDataRecords() else {
            return true
        }
        for record in dataRecords {
            if let strDate = record.createdDate,
                let recordDate = Date.dateFromString(dateString: strDate),
                recordDate.compare(date) == ComparisonResult.orderedDescending {
                return false
            }
        }
        return true
    }
    
    

    func estimatedCaloPerDay(_ certainWeight:Float = -1,_ certainHeight:Float = -1) -> Float?{
        guard let user = self.currentUser else {
            return nil
        }
        var weight:Float = 0
        var height:Float = 0
        let age = user.birthday.age()
        
        if(certainWeight < 0 || certainHeight < 0){
            weight = user.weight
            height = user.height
        }else{
            weight = certainWeight
            height = certainHeight
        }

        var fixedNum: Float
        if (user.sex){
            fixedNum = AppConfig.fixedNum.male.rawValue
        }else{
            fixedNum = AppConfig.fixedNum.female.rawValue
        }
        
        let w = (AppConfig.numForCalculation.weight.rawValue * weight)
        let h = (AppConfig.numForCalculation.height.rawValue * height)
        let a = (AppConfig.numForCalculation.age.rawValue * Float(age))
        
        let basalmetabolicRate:Float = (w + h - a - fixedNum) * Float(1000)/4.186
        
        var levelOfPhysicalActivity: Float = 0
        
        if(age >= 18 && age <= 69){
            switch(user.momentum){
            case 0:
                levelOfPhysicalActivity = AppConfig.momentumUnder70.low.rawValue
                break
            case 1:
                levelOfPhysicalActivity = AppConfig.momentumUnder70.normal.rawValue
                break
            case 2:
                levelOfPhysicalActivity = AppConfig.momentumUnder70.hight.rawValue
                break
            default: break
            }
        } else if(age >= 70){
            switch(user.momentum){
            case 0:
                levelOfPhysicalActivity = AppConfig.momentumOver70.low.rawValue
                break
            case 1:
                levelOfPhysicalActivity = AppConfig.momentumOver70.normal.rawValue
                break
            case 2:
                levelOfPhysicalActivity = AppConfig.momentumOver70.hight.rawValue
                break
            default: break
            }
            
        }
        let recommendedCalorieIntake = basalmetabolicRate * levelOfPhysicalActivity
        return recommendedCalorieIntake
    }

    func totalCaloTarget() -> Float? {
        guard let user = self.currentUser else {
            return nil
        }
        
        return (user.targetWeight - user.weight) * 7200
    }
    
    func resetUserData(userInfo: UserInfo) {
        guard let user = self.currentUser else {
            return
        }
        let predicate = NSPredicate.init(format: "userId = %@", user.id)
        let data = self.realm.objects(DataRecording.self).filter(predicate)
        do {
            weak var weakSelf = self
            _ = try realm.write {
                weakSelf!.realm.delete(data)
            }
        } catch {}
    }
    
}

