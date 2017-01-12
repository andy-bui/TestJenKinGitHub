//
//  HelpViewController.swift
//  Health App
//
//  Created by Nguyen Chi Thanh on 1/6/17.
//  Copyright © 2017 Cong Phu. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var helpWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helpWebView.delegate = self
        let request = URLRequest(url: URL(string: AppConfig.helpLink)!)
        helpWebView.loadRequest(request)
    }

}
