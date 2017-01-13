//
//  UserObject.swift
//  Health App
//
//  Created by Nguyen Chi Thanh on 12/29/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation

class UserObject {
    var sex = true
    var birthday:Date = Date()
    var username = ""
    var height: Float = 0.0
    var weight:Float = 0.0
    var bodyFat:Float = -1.0
    var targetWeight:Float = 0.0
    var momentum:Int = 0
    init(userInfo: UserInfo) {
        self.sex = userInfo.sex
        self.birthday = userInfo.birthday
        self.height = userInfo.height
        self.weight = userInfo.weight
        self.bodyFat = userInfo.bodyFat
        self.targetWeight = userInfo.targetWeight
        self.momentum = userInfo.momentum
    }
}
