//
//  NewsViewController.swift
//  Health App
//
//  Created by Nguyen Tan Thanh on 12/22/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var newsWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsWebView.delegate = self
        let request = URLRequest(url: URL(string: AppConfig.helpLink)!)
        newsWebView.loadRequest(request)
    }
}
