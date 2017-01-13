//
//  UIViewSeparators.swift
//  myDriver-Driver-V3.0
//
//  Created by Johannes Koepcke on 29/08/2016.
//  Copyright © 2016 e-Sixt GmbH & Co. KG. All rights reserved.
//

import UIKit

extension UIView {

    @discardableResult func addTopSeparator(withLeftInset leftInset: CGFloat = 0, rightInset: CGFloat = 0, separatorColor: UIColor? = nil) -> UIView {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = separatorColor ?? defaultSeparatorColor()
        self.addSubview(separator)
        separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftInset).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: rightInset).isActive = true
        separator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: defaultHeight()).isActive = true
        return separator
    }

    @discardableResult func addBottomSeparator(withLeftInset leftInset: CGFloat = 0, rightInset: CGFloat = 0, separatorColor: UIColor? = nil) -> UIView {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = separatorColor ?? defaultSeparatorColor()
        self.addSubview(separator)
        separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftInset).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: rightInset).isActive = true
        separator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: defaultHeight()).isActive = true
        return separator
    }

    fileprivate func defaultHeight() -> CGFloat {
        return 1 / UIScreen.main.scale
    }

    fileprivate func defaultSeparatorColor() -> UIColor {
        return AppConfig.Colors.mainSeparatorColor
    }

}
