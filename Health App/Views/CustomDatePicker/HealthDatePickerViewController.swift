//
//  HealthDatePickerViewController.swift
//  Health App
//
//  Created by Nhoc Con on 12/27/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import UIKit

typealias actionDoneDatePicker = (Date) -> Void
class HealthDatePickerViewController: UIViewController {
    @IBOutlet weak var picker: HealthDatePickerView!
    var action : actionDoneDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isOpaque = false
        
        let tapToClose = UITapGestureRecognizer(target: self, action: #selector(self.doTapToClose))
        view.addGestureRecognizer(tapToClose)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationShowPicker()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func animationShowPicker() {
        let currentFrame = picker.frame
        picker.frame = CGRect(x: 0, y: view.bounds.height, width: picker.frame.width, height: picker.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.picker.frame = currentFrame
        })
    }
    func doTapToClose(){
        if let action = self.action {
            let date = picker.getPickerValueToDate()
            action(date)
        }
        self.dismiss(animated: false, completion: nil)
    }
}
