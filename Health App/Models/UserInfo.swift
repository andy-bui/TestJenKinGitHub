//
//  UserInfo.swift
//  Health App
//
//  Created by Cong Phu on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import RealmSwift

class UserInfo: Object {
    
    dynamic var id = NSUUID().uuidString
    dynamic var sex = true
    dynamic var birthday:Date!
    dynamic var username = ""
    dynamic var height: Float = 0.0
    dynamic var weight:Float = 0.0
    dynamic var bodyFat:Float = -1.0
    dynamic var targetWeight:Float = 0.0
    dynamic var momentum:Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ sex: Bool, birthday: Date, height: Float, weight:Float, targetWeight:Float,
         momentum:Int, bodyFat:Float = 0.0, username: String = "" ) {
        self.init()
        self.sex = sex
        self.birthday = birthday
        self.username = username
        self.height = height
        self.weight = weight
        self.bodyFat = bodyFat
        self.targetWeight = targetWeight
    }
    
   
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
