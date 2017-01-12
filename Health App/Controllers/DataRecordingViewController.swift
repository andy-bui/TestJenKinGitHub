//
//  DataRecordingViewController.swift
//  Health App
//
//  Created by Cong Phu on 12/21/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import UIKit

class DataRecordingViewController: BaseTableViewController, DataRecordingDataSourceDelegate {

    @IBOutlet weak var textBodyWeight: UITextField!
    @IBOutlet weak var textBodyFat: UITextField!
    @IBOutlet weak var lbCurrentDate: UILabel!
    @IBOutlet weak var btnSave: GreenButton!
    @IBOutlet weak var lbSumCalories: UILabel!
    @IBOutlet weak var btnRegister: GreenButton!
    @IBOutlet weak var lbInputVersion: UILabel!
    @IBOutlet weak var lbMiddleConstraintTrailing: NSLayoutConstraint!
    @IBOutlet weak var lbMiddle: UILabel!
    var validData: Bool = false {
        didSet {
            self.rightBarButton.isEnabled = validData
        }
    }
    var recommendedCalories: Int = 0
    lazy var rightBarButton: UIBarButtonItem = {
        let rightBarButton = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(DataRecordingViewController.done))
        rightBarButton.tintColor = AppConfig.Colors.mainColorOrange
        return rightBarButton

    }()
    
    lazy var bikoConstraint: CGFloat = {
        return self.lbMiddle.frame.origin.x - UIScreen.main.bounds.width
    }()
    
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
        self.btnRegister.backgroundColor = AppConfig.Colors.mainColorOrange
        self.tableView.layer.cornerRadius = 10
        self.textBodyWeight.addTarget(self, action: #selector(DataRecordingViewController.textChanged(_:)), for: .editingChanged)
        self.textBodyFat.addTarget(self, action: #selector(DataRecordingViewController.textChanged(_:)), for: .editingChanged)
                self.navigationItem.rightBarButtonItem = self.rightBarButton
        let dataRecordingDataSource = DataRecordingDataSource()
        dataRecordingDataSource.dataRecordingDelegate = self
        self.tableViewDataSource = dataRecordingDataSource
        super.viewDidLoad()
        self.reloadData(at: Date())
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        vc.hidesBottomBarWhenPushed = true
    }
    
    override func didValidateData(_ valid: Bool) {
        
        guard  let dataSource = self.tableViewDataSource as? DataRecordingDataSource  else {
            self.validData = false
            return
        }
        var calories: Int = 0
        for meal in dataSource.meals {
            calories += meal.calorie
        }
        let caloriesStr = calories.description
        self.lbSumCalories.text = caloriesStr + " kal"
        
        guard let bodyWeight = Float(self.textBodyWeight.text!),
        let bodyFat = Float(self.textBodyFat.text!) else {
            self.validData = false
            return
        }
        dataSource.bodyFat = bodyFat
        dataSource.bodyWeight = bodyWeight
        dataSource.totalCalories = calories
        self.validData = valid
    }
    
    
    
    override func showDialog() {
        guard let dataSource = self.tableViewDataSource as? DataRecordingDataSource else {
            return
        }
        
        Utils.showDialogAddNewMeal(viewController: self) { (type) in
            var meal: MealInfo?
            switch type {
            case .snack:
                meal = MealInfo(name: AppConfig.Strings.snack)
            case .midNightSnack:
                meal = MealInfo(name: AppConfig.Strings.nightSnack)
            case .otherMeal:
                meal = MealInfo(name: AppConfig.Strings.otherMeal)
            default: break
                
            }
            guard let newMeal = meal else {
                return
            }
            dataSource.addNewMeal(newMeal: newMeal)
        }
    }
    
    @IBAction func registerBiko(_ sender: Any) {
        guard let dataSource = self.tableViewDataSource as? DataRecordingDataSource else {
                return
        }
        Utils.showDialogSelectBikokusai(viewController: self) { (type, name) in
            dataSource.bikoType = type
        }
    }
    
    func saveData() {
        guard  let dataSource = self.tableViewDataSource as? DataRecordingDataSource  else {
            return
        }
        dataSource.saveData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToPreDate(_ sender: Any) {
        guard  let dataSource = self.tableViewDataSource as? DataRecordingDataSource  else {
            return
        }
        let date = dataSource.currentDate?.preDate()
        self.reloadData(at: date)
    }
    
    @IBAction func goToNextDate(_ sender: Any) {
        guard  let dataSource = self.tableViewDataSource as? DataRecordingDataSource  else {
            return
        }
        let date = dataSource.currentDate?.nextDate()
        self.reloadData(at: date)
    }
    
    @IBAction func showCalendar(_ sender: Any) {
        weak var weakSelf = self
        var currentDate: Date?
        if let text = self.lbCurrentDate.text {
            currentDate = Date.dateFromString(dateString: text.replacingOccurrences(of: "(木)", with: ""))
        }
        self.showDatePicker(actionCallback: { (date) in
             weakSelf!.reloadData(at: date)
        }, fromDate: nil, toDate: nil, selectedDate: currentDate)
        
    }

    
    func reloadData(at date: Date?) {
        guard  let dataSource = self.tableViewDataSource as? DataRecordingDataSource,
        let dateStr = date?.toString() else {
            return
        }
        dataSource.recommendedCalories = self.recommendedCalories
        dataSource.currentDate = date
        
        if let bodyWeight = dataSource.bodyWeight {
            self.textBodyWeight.text = bodyWeight.formatToString()
        }else {
            self.textBodyWeight.text = ""
        }
        
        if let bodyFat = dataSource.bodyFat {
            self.textBodyFat.text = bodyFat.formatToString()
        }else {
            self.textBodyFat.text = ""
        }

        self.lbCurrentDate.text = dateStr + " (木) "
        _ = dataSource.validate()
        self.didChangeBikoType(type: dataSource.bikoType)
        self.tableView.reloadData()
    }
    
    func textChanged(_ sender: Any) {
       _ = self.tableViewDataSource?.validate()
    }
    
    func done() {
        self.saveData()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK - DataRecordingDataSourceDelegate 
    
    func didChangeBikoType(type: BikokusaiType) {
        self.btnRegister.isHidden = type != .none
        self.lbInputVersion.text = type == .none ? AppConfig.Strings.normalVerString : AppConfig.Strings.bikoVerString
        self.lbMiddle.isHidden = type != .none
        self.lbMiddleConstraintTrailing.constant = type == .none ? 8 : self.bikoConstraint
    }
    
    func updateBikoInfo(mealInfo: MealInfo, cellModel: BikoInputCellModel) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "HowToDrinkViewController") as? HowToDrinkViewController else {
            return
        }
        weak var weakSelf = self
        vc.selectAction = { bikoItem in
            guard let bikoItemCalorie = bikoItem.secondTitle else {
                return
            }
            mealInfo.bikoItemName = bikoItem.title
            mealInfo.bikoItemCalorie = Int(bikoItemCalorie) ?? 0
            cellModel.bikoItemName = bikoItem.title
            cellModel.bikoItemCalorie = mealInfo.bikoItemCalorie
            if mealInfo.bikoItemCalorie > 0 {
                mealInfo.calorie = Int(Float(mealInfo.calorie)/3 + 0.5) - mealInfo.bikoItemCalorie
                cellModel.content = mealInfo.calorie.description
            }
            _ = weakSelf!.tableViewDataSource?.validate()
            weakSelf!.tableView.reloadData()
        }
        self.navigationController?.present(UINavigationController.init(rootViewController: vc), animated: true, completion: nil)
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
