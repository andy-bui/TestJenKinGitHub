//
//  Meal.swift
//  Health App
//
//  Created by Cong Phu on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import RealmSwift

class Meal: Object {
    
    dynamic var id = NSUUID().uuidString
    dynamic var name:String!
    dynamic var calorie: Int = 600
    dynamic var bikoItemName: String?
    dynamic var bikoItemCalorie: Int = 0
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(name: String, id: String = NSUUID().uuidString, calorie: Int = 600) {
        self.init()
        self.id = NSUUID().uuidString
        self.name = name
        self.calorie = calorie
    }
    
    convenience init(mealInfo: MealInfo) {
        self.init()
        self.id = mealInfo.id
        self.name = mealInfo.name
        self.calorie = mealInfo.calorie
        self.bikoItemName = mealInfo.bikoItemName
        self.bikoItemCalorie = mealInfo.bikoItemCalorie
    }
    
    
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
