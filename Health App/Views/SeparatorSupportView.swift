//
//  SeparatorSupportView.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import UIKit

protocol SeparatorSupportView : class {
    var topSeparatorView: UIView? { get set }
    var topSeparator: Bool { get set }
    var topSeparatorLeftInset: CGFloat { get set }
    var topSeparatorRightInset: CGFloat { get set }
    var bottomSeparatorView: UIView? { get set }
    var bottomSeparator: Bool { get set }
    var bottomSeparatorLeftInset: CGFloat { get set }
    var bottomSeparatorRightInset: CGFloat { get set }
    var separatorColor: UIColor? { get set }

    func updateView()
}

extension SeparatorSupportView where Self: UIView {

    func configureViewForStyle(topSeparatorStyle: SeparatorStyle, bottomSeparatorStyle: SeparatorStyle) {
        self.topSeparator = true
        switch topSeparatorStyle {
        case .none:
            self.topSeparator = false
        case .full:
            self.topSeparatorLeftInset = 0
            self.topSeparatorRightInset = 0
        case .inset:
            self.topSeparatorLeftInset = 20
            self.topSeparatorRightInset = 0
        }
        self.bottomSeparator = true
        switch bottomSeparatorStyle {
        case .none:
            self.bottomSeparator = false
        case .full:
            self.bottomSeparatorLeftInset = 0
            self.bottomSeparatorRightInset = 0
        case .inset:
            self.bottomSeparatorLeftInset = 20
            self.bottomSeparatorRightInset = 0
        }
        updateView()
    }

    internal func updateView() {
        self.topSeparatorView?.removeFromSuperview()
        if topSeparator {
            self.topSeparatorView = self.addTopSeparator(withLeftInset: self.topSeparatorLeftInset, rightInset: topSeparatorRightInset, separatorColor: separatorColor)
        }

        self.bottomSeparatorView?.removeFromSuperview()
        if bottomSeparator {
            self.bottomSeparatorView = self.addBottomSeparator(withLeftInset: self.bottomSeparatorLeftInset, rightInset: bottomSeparatorRightInset, separatorColor: separatorColor)
        }
    }
}
