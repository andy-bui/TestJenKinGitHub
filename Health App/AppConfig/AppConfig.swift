
//
//  AppConfig.swift
//  Health App
//
//  Created by Cong Phu on 12/21/16.
//  Copyright © 2016 Cong Phu. All rights reserved.

import Foundation
import UIKit

class AppConfig {

    static let helpLink = "https://www.brooks.co.jp/apphelp/"
    static let formatDate = "yyyy/M/dd"
    static let formatTime = "h : mm a"
    static let segmentMargin: CGFloat = 20
    static let segmentDefaultWidth: CGFloat = 40
    static let btnActivityDetailDefaultWidth: CGFloat = 90
    static let iconDefaultWidth:CGFloat = 60
    static let btnChangeTrailingConstraintHidden:CGFloat = -100
    static let btnChangeTrailingConstraintShown:CGFloat = 15
    
    struct Nibs {
        static let textInputCell = "TextInputCell"
        static let segmentedCell = "SegmentedCell"
        static let singleItemContentCell = "SingleItemContentCell"
        static let singleItemCell = "SingleItemCell"
        static let momentumView = "MomentumView"
        static let singleItemButtonCell = "SingleItemButtonCell"
        static let addMoreCell = "AddMoreCell"
        static let bikoInputCell = "BikoInputCell"
        static let addNewMealDialog = "AddNewMealDialog"
        static let selectBikokusaiDialog = "SelectBikokusaiDialog"
        static let inputSegmentedCell = "InputSegmentedCell"
        static let normalHome = "NormalHome"
        static let bikoHome = "BikoHome"
    }
    
    enum momentumUnder70: Float {
        case low    = 1.50
        case normal = 1.75
        case hight  = 2.00
    }
    
    enum momentumOver70: Float {
        case low    = 1.45
        case normal = 1.70
        case hight  = 1.95
    }
    
    enum fixedNum: Float{
        case male   = 0.4235
        case female = 0.9708
    }
    
    enum numForCalculation: Float{
        case weight = 0.0481
        case height = 0.0234
        case age    = 0.0138
    }

}
