//
//  MealInfo.swift
//  Health App
//
//  Created by Cong Phu on 1/5/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import Foundation

class MealInfo {
    var id = NSUUID().uuidString
    var name:String!
    var calorie: Int = 600
    var bikoItemName: String?
    var bikoItemCalorie: Int = 0
    
    init(name: String, calorie: Int = 600, id: String = NSUUID().uuidString) {
        self.id = NSUUID().uuidString
        self.name = name
        self.calorie = calorie
    }

    
    init(meal: Meal) {
        self.id = meal.id
        self.name = meal.name
        self.calorie = meal.calorie
        self.bikoItemName = meal.bikoItemName
        self.bikoItemCalorie = meal.bikoItemCalorie
    }
    
    class func createMealsDefault(recommendedCalories: Int) -> [MealInfo] {
        let calorie = Int(Float(recommendedCalories)/3 + 0.5)
        let morning = MealInfo(name: AppConfig.Strings.morning, calorie: calorie)
        let noom = MealInfo(name: AppConfig.Strings.noom, calorie: calorie)
        let night = MealInfo(name: AppConfig.Strings.night, calorie: calorie)
        return [morning, noom, night]
    }
}
