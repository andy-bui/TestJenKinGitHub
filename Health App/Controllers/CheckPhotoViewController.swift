//
//  CheckPotoViewController.swift
//  Health App
//
//  Created by Cong Phu on 12/21/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import UIKit

class CheckPhotoViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func save(_ sender: Any) {
        guard let controllers = self.navigationController?.viewControllers else {
            return
        }
        
        for vc in controllers {
            guard let inputVc = vc as? DataRecordingViewController else {
                return
            }
            
            _ = self.navigationController?.popToViewController(inputVc, animated: true)
            return
        }
    }

    @IBAction func cancel(_ sender: Any) {
       _ = self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
