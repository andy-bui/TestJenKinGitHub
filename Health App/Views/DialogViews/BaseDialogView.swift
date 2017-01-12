//
//  BaseDialogView.swift
//  Health App
//
//  Created by Nhoc Con on 12/29/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

protocol BaseDialogViewDelegate : class {
    func hideDialog()
}

class BaseDialogView : UIView {
    weak var delegate: BaseDialogViewDelegate?
    func hideDialog() {
        delegate?.hideDialog()
    }
}
