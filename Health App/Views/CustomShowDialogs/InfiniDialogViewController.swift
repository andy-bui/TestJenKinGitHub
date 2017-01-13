//
//  InfiniDialogViewController.swift
//  InfiniHealth_Temp
//
//  Created by Nhoc Con on 12/21/16.
//  Copyright © 2016 Nhoc Con. All rights reserved.
//

import UIKit

class InfiniDialogViewController: UIViewController, BaseDialogViewDelegate {
    let cornerValue = 15
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewAlertContent: UIView!
    
    @IBOutlet weak var wContentView: NSLayoutConstraint!
    @IBOutlet weak var hContentView: NSLayoutConstraint!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var hTitle: NSLayoutConstraint!
    
    @IBAction func doClose(_ sender: Any) {
        animationShowHideDialog(isShow: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContent.isHidden = true
        let tapOverToClose : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.doTapOverToClose))
        viewBG.addGestureRecognizer(tapOverToClose)
    }
    func doTapOverToClose(){
        animationShowHideDialog(isShow: false)
    }
    func hideDialog() {
        animationShowHideDialog(isShow: false)
    }
    
    func addAlertView(viewDialog : BaseDialogView, isTitle : Bool = false, title : String? = nil) {
        viewDialog.delegate = self
        hTitle.constant = isTitle ? 40 : 0
        viewTitle.isHidden = isTitle ? false : true
        
        if let dgTitle = title {
            lbTitle.text = dgTitle
            viewTitle.backgroundColor = AppConfig.Colors.popupTitleGreen
        }else{
            lbTitle.text = ""
            viewTitle.backgroundColor = UIColor.white
        }
        
        wContentView.constant = viewDialog.frame.width
        hContentView.constant = viewDialog.frame.height + hTitle.constant
        
        viewContent.updateConstraints()
        viewContent.layoutIfNeeded()
        viewContent.layoutSubviews()
        
        viewAlertContent.addSubview(viewDialog)
        setCorner(viewDialog: viewDialog, isTitle: isTitle)
        animationShowHideDialog(isShow: true)
    }
    
    func setCorner(viewDialog : UIView, isTitle : Bool) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: viewContent.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerValue, height: cornerValue)).cgPath
        viewTitle.layer.mask = maskLayer
        
        let maskLayer2 = CAShapeLayer()
        if isTitle {
            maskLayer2.path = UIBezierPath(roundedRect: viewDialog.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerValue, height: cornerValue)).cgPath
        }else{
            maskLayer2.path = UIBezierPath(roundedRect: viewDialog.bounds, byRoundingCorners: [.bottomLeft, .bottomRight, .topRight, .topLeft], cornerRadii: CGSize(width: cornerValue, height: cornerValue
            )).cgPath
        }
        
        viewDialog.layer.mask = maskLayer2
    }
    
    func animationShowHideDialog(isShow : Bool) {
        viewContent.isHidden = false
        let alphaBGFrom = isShow ? 0 : 0.5
        let alphaBGTo = isShow ? 0.5 : 0
        let alphaViewFrom = isShow ? 0 : 1
        let alphaViewTo = isShow ? 1 : 0
        let scaleFrom = isShow ? (x : 1.2, y : 1.2) : (x : 1.0, y : 1.0)
        let scaleTo = isShow ? (x : 1.0, y : 1.0) : (x : 1.2, y : 1.2)
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(CGFloat(alphaBGFrom))
        self.viewContent.alpha = CGFloat(alphaViewFrom)
        self.viewContent.transform = CGAffineTransform(scaleX: CGFloat(scaleFrom.x), y: CGFloat(scaleFrom.y))

        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(CGFloat(alphaBGTo))
            self.viewContent.alpha = CGFloat(alphaViewTo)
            self.viewContent.transform = CGAffineTransform(scaleX: CGFloat(scaleTo.x), y: CGFloat(scaleTo.y))
        }) { (isComplete) in
            if !isShow{
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}
