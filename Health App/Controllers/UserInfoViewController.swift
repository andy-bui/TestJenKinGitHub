//
//  UserInfoViewController.swift
//  Health App
//
//  Created by Cong Phu on 12/21/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import UIKit

class UserInfoViewController: BaseTableViewController {

    @IBOutlet weak var btnHome: UIButton!
    override func viewDidLoad() {
        self.tableViewDataSource = UserInfoDataSource()
        super.viewDidLoad()
        self.didValidateData(false)
        self.btnHome.isEnabled = false
        // Do any additional setup after loading the view.
        
        if (!UserDefaults.getWelcomeFirstClick()) {
            let v = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeScreen")
            self.present(v, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userInfoDataSource = self.tableViewDataSource as? UserInfoDataSource else {
                
            return
        }
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        UserDataManager.sharedInstance.saveUserInfo(userInfo: userInfoDataSource.userInfo)
    }
    
    override func didValidateData(_ valid: Bool) {
        self.btnHome.isEnabled = valid
    }
    
    override func showDialog() {
        guard let momentumView = Bundle.main.loadNibNamed(AppConfig.Nibs.momentumView, owner: self, options: nil)?.first as? BaseDialogView else {
            return
        }
        var frame = momentumView.frame
        let screenBounds = UIScreen.main.bounds
        frame.size.height = 0.8 * screenBounds.height
        frame.size.width = 0.9 * screenBounds.width
        momentumView.frame = frame
        self.showDialog(view: momentumView, isTitle: true, title: nil)
    }
    
    override func didSelectAction(_ action: BaseDataSourceAction) {
        if action == UserInfoAction.birthdaySelection {
            guard let userInfoDataSource = self.tableViewDataSource as? UserInfoDataSource,
                let cellModel = userInfoDataSource.cellModel(forRow: 1) as? InputDataCellModel,
                let strDate = cellModel.content else {
                return
            }
            
            weak var weakSelf = self
            self.showDatePicker(actionCallback: { (date) in
                userInfoDataSource.userInfo.birthday = date
                cellModel.content = date.toString()
                weakSelf!.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0) ], with: .none)
                _ = userInfoDataSource.validate()

            }, fromDate: nil, toDate: Date().birthdayFromAge(age: -18), selectedDate: Date.dateFromString(dateString: strDate))
        }
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
