//
//  SeparatorView.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import UIKit

enum SeparatorStyle {
    case none
    case full
    case inset
}

@IBDesignable
class SeparatorView: UIView, SeparatorSupportView {

    internal var topSeparatorView: UIView? = nil
    @IBInspectable var topSeparator: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable var topSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var topSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    internal var bottomSeparatorView: UIView? = nil
    @IBInspectable var bottomSeparator: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var separatorColor: UIColor?

}

@IBDesignable
class SeparatorTextField: UITextField, SeparatorSupportView {

    internal var topSeparatorView: UIView? = nil
    @IBInspectable var topSeparator: Bool = false {
        didSet {
            updateView()
        }
    }

    @IBInspectable var topSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var topSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    internal var bottomSeparatorView: UIView? = nil
    @IBInspectable var bottomSeparator: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var separatorColor: UIColor?

}

@IBDesignable
class SeparatorButton: UIButton, SeparatorSupportView {

    internal var topSeparatorView: UIView? = nil
    @IBInspectable var topSeparator: Bool = false {
        didSet {
            updateView()
        }
    }

    @IBInspectable var topSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var topSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    internal var bottomSeparatorView: UIView? = nil
    @IBInspectable var bottomSeparator: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var separatorColor: UIColor?

}

@IBDesignable
class SeparatorTableViewCell: UITableViewCell, SeparatorSupportView {

    internal var topSeparatorView: UIView? = nil
    @IBInspectable var topSeparator: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable var topSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var topSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    internal var bottomSeparatorView: UIView? = nil
    @IBInspectable var bottomSeparator: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var separatorColor: UIColor?

}

@IBDesignable
class SeparatorCollectionReusableView: UICollectionReusableView, SeparatorSupportView {

    internal var topSeparatorView: UIView? = nil
    @IBInspectable var topSeparator: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable var topSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var topSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    internal var bottomSeparatorView: UIView? = nil
    @IBInspectable var bottomSeparator: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var separatorColor: UIColor?

}

@IBDesignable
class SeparatorCollectionViewCell: UICollectionViewCell, SeparatorSupportView {

    internal var topSeparatorView: UIView? = nil
    @IBInspectable var topSeparator: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable var topSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var topSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    internal var bottomSeparatorView: UIView? = nil
    @IBInspectable var bottomSeparator: Bool = false {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorLeftInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomSeparatorRightInset: CGFloat = 0 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var separatorColor: UIColor?

}
