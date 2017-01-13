//
//  GreenButton.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/30/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit


class GreenButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setTitleColor(AppConfig.Colors.mainColorLight, for: .normal)
        self.layer.cornerRadius = 6
        self.backgroundColor = AppConfig.Colors.mainColorGreen
        self.layer.shadowColor = UIColor.black.cgColor;
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
        self.layer.opacity = self.isEnabled ? 1.0 : 0.5
    }
    
    override var isEnabled: Bool {
        didSet {
            self.layer.opacity = isEnabled ? 1.0 : 0.5
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? AppConfig.Colors.mainColorOrange : AppConfig.Colors.mainColorGreen
        }
    }
}
