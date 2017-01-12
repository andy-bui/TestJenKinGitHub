//
//  UserDataRecording.swift
//  Health App
//
//  Created by Cong Phu on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import RealmSwift

class DataRecording: Object {

    dynamic var id = NSUUID().uuidString
    dynamic var userId:String!
    dynamic var bodyWeight:Float = 0.0
    dynamic var bodyFat:Float = 0.0
    let meals = List<Meal>()
    dynamic var createdDate: String? = Date().toString()
    dynamic var bikoType: Int = -1 // Normal Data Recording
    dynamic var intakeCalories: Int = 0
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ userId: String, bodyWeight: Float = 0.0, bodyFat: Float = 0.0, date: String? = Date().toString()) {
        self.init()
        self.userId = userId
        self.bodyWeight = bodyWeight
        self.bodyFat = bodyFat
        self.createdDate = date
    }
    
    func update(bodyWeight: Float, bodyFat: Float, meals: [Meal], bikoType: Int, intake: Int) {
        guard let realm = self.realm else {
            return
        }
        weak var weakSelf = self
        _  = try! realm.write {
            self.bikoType = bikoType
            self.intakeCalories = intake
            self.bodyWeight = bodyWeight
            self.bodyFat = bodyFat
            for meal in meals {
                if let filteredMeal = weakSelf?.meals.filter("id = %@", meal.id).first  {
                    filteredMeal.calorie = meal.calorie
                    filteredMeal.bikoItemName = meal.bikoItemName
                    filteredMeal.bikoItemCalorie = meal.bikoItemCalorie
                    filteredMeal.bikoItemName = meal.bikoItemName
                    filteredMeal.bikoItemCalorie = meal.bikoItemCalorie
                }else {
                    realm.add(meal, update: true)
                    weakSelf!.meals.append(meal)
                }
            }
        }
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
