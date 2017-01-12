//
//  HomeViewController.swift
//  Health App
//
//  Created by Cong Phu on 12/21/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//


import UIKit
import CircleProgressView
import RealmSwift
class HomeViewController:BaseViewController  {
    @IBOutlet weak var lbCalo: UILabel!
    
    @IBOutlet weak var lbFat: UILabel!
    @IBOutlet weak var lbWeight: UILabel!
    @IBOutlet weak var meterView: UIView!
    @IBOutlet weak var dayNumView: UIView!
    @IBOutlet weak var instructionBox: UIView!
    @IBOutlet weak var lbCaloSaving: UILabel!
    @IBOutlet weak var caloSavingIntake: UILabel!
    @IBOutlet weak var lbKcal: UILabel!
    @IBOutlet weak var imageDay: UIImageView!
    @IBOutlet weak var textDayNo: UILabel!
    
    ////////// normal
     @IBOutlet weak var normalView: UIView!
    @IBOutlet weak var normalK: UIImageView!
    @IBOutlet weak var lbNormal1: UILabel!
    @IBOutlet weak var lbNormal2: UILabel!
    @IBOutlet weak var lbNormal3: UILabel!
    
    @IBOutlet weak var normalMeter: CircleProgressView?
    @IBOutlet weak var reducedCaloIntake: UILabel?
    
    ////////// biko
    @IBOutlet weak var bikoView: UIView!
    @IBOutlet weak var reducedCaloIntakeBiko: UILabel?
    @IBOutlet weak var bikoMeter: UISlider?

    var dayNum = 0
    var totalCalories:Float = 0
    var caloInDay:Float = 0
    var remainTargetCalo:Float = 0
    var caloPerDay:Float = 0
    var caloTarget:Float = 0
    var height:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbCaloSaving?.adjustsFontSizeToFitWidth = true
        lbKcal?.adjustsFontSizeToFitWidth = true
        caloSavingIntake?.adjustsFontSizeToFitWidth = true
        
        lbWeight.adjustsFontSizeToFitWidth = true
        lbFat.adjustsFontSizeToFitWidth = true
        lbCalo.adjustsFontSizeToFitWidth = true

        
        if let caloTarget = UserDataManager.sharedInstance.totalCaloTarget(){
            self.caloTarget = caloTarget
        }
        
        if let dataRecords = UserDataManager.sharedInstance.getAllDataRecords(){
            dayNum = dataRecords.count
            
            if(dayNum <= 0){
                setNoDataScreen()
            }else{
                setDataScreen(dataRecords)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVc = segue.destination as? UINavigationController,
            let dataRecording = destVc.topViewController as? DataRecordingViewController else {
            return
        }
        dataRecording.recommendedCalories = Int(roundf(self.caloPerDay))
    }
    
    func setDataScreen(_ dataRecords: Results<DataRecording>) {
        if let height = UserDataManager.sharedInstance.currentUser?.height{
            self.height = height
        }
        
        self.normalMeter?.trackBackgroundColor = AppConfig.Colors.trackBackgroundColor
        self.dayNumView.isHidden         = false
        self.instructionBox.isHidden     = true
        self.caloSavingIntake.isHidden   = false
        self.lbKcal.isHidden             = false
        self.lbCaloSaving.isHidden       = false
        
        if(UserDefaults.bikokusaiDesign) {
            addBikoView()
            imageDay.image = UIImage(named: "bikokusai_text")
        }else{
            addNormalView()
            normalK.isHidden   = true
            lbNormal1.isHidden = true
            lbNormal2.isHidden = true
            lbNormal3.isHidden = true
            normalMeter?.trackBackgroundColor = AppConfig.Colors.trackBackgroundColor
            imageDay.image = UIImage(named: "normal_text")
        }
        meterView.bringSubview(toFront: lbCaloSaving)
        meterView.bringSubview(toFront: caloSavingIntake)
        meterView.bringSubview(toFront: lbKcal)
        
        let lastDataRC:DataRecording = dataRecords[dayNum - 1]
        
        ////////////////////// set label weight
        var string = ""
        if(lastDataRC.bodyWeight >= 0){
            if let str = lastDataRC.bodyWeight.formatToString(){
                string = "\(str) kg"
            }
        }else{
            string = "0 kg"
        }
        
        var kNum:Int = string.characters.count - 2
        var mutatingText = NSMutableAttributedString(string: string)
        mutatingText.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSRange(location:kNum,length:2))
        lbWeight.attributedText = mutatingText
        
        ////////////////////// set label fat
        if(lastDataRC.bodyFat >= 0){
            if let str = lastDataRC.bodyFat.formatToString(){
                string = "\(str) %"
            }
        }else{
            string = "0 %"
        }
        kNum = string.characters.count - 1
        mutatingText = NSMutableAttributedString(string: string)
        mutatingText.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSRange(location:kNum,length:1))
        lbFat.attributedText = mutatingText
        
        /////////////////////// set label caloPerDay
        if let caloPerDay = UserDataManager.sharedInstance.estimatedCaloPerDay(lastDataRC.bodyWeight, lastDataRC.bodyFat){
            self.caloPerDay = caloPerDay
            if let str = caloPerDay.roundToString(){
                let string = "\(str) kcal"
                let kNum:Int = string.characters.count - 4
                let mutatingText = NSMutableAttributedString(string: string)
                
                mutatingText.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSRange(location:kNum,length:4))
                lbCalo.attributedText = mutatingText
                
            }
        }

        
        ///////////////////////// set saved calo, reaching calo target & meter value
        var totalCaloSaved:Float = 0
        var caloSavedPerday:Float  = 0
        for dataRC in dataRecords{
            if let caloPerDay = UserDataManager.sharedInstance.estimatedCaloPerDay(dataRC.bodyWeight, dataRC.bodyFat){
                caloSavedPerday = Float(dataRC.intakeCalories) - caloPerDay
                totalCaloSaved += caloSavedPerday
            }
        }
        
        let meterValue = Double(totalCaloSaved) / Double(caloTarget)
        
        remainTargetCalo = (caloTarget - totalCaloSaved)
        if(meterValue >= 0){
            setCaloIntake(meterValue)
        }
        
        caloSavingIntake.text  = totalCaloSaved.roundToString()
        
        if let remainCalo = remainTargetCalo.roundToString() {
            reducedCaloIntake?.text = "   目標まで \(remainCalo) kcal   "
            reducedCaloIntakeBiko?.text = "目標まで \(remainCalo) kcal"
        }
        textDayNo.text = "\(dayNum)"
    }
    
    func setNoDataScreen() {
        dayNumView.isHidden         = true
        instructionBox.isHidden     = false
        lbCaloSaving.isHidden      = true
        caloSavingIntake.isHidden   = true
        lbKcal.isHidden            = true
        
        imageDay.image             = UIImage(named: "normal_text")
        
        addNormalView()
        normalMeter?.trackBackgroundColor = AppConfig.Colors.trackBackgroundColor
        normalK?.isHidden      = false
        lbNormal1?.isHidden    = false
        lbNormal2?.isHidden    = false
        lbNormal3?.isHidden    = false
        
        if let caloTarget = self.caloTarget.formatToString() {
            reducedCaloIntake?.text = "  目標まで \(caloTarget) kcal    "
        }
        
        textDayNo.text = "0"
        setCaloIntake(-1)
        
        if let weight = (UserDataManager.sharedInstance.currentUser?.weight) {
            if let str = weight.formatToString(){
                let string = "\(str) kg"
                let kNum:Int = string.characters.count - 2
                let mutatingText = NSMutableAttributedString(string: string)
                
                mutatingText.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSRange(location:kNum,length:2))
                lbWeight.attributedText = mutatingText
            }  
        }
        
        if let fat = (UserDataManager.sharedInstance.currentUser?.bodyFat) {
            var string = ""
            if(fat < 0){
                string = "0 %"
            } else {
                if let str = fat.formatToString(){
                    string = "\(str) %"
                }
            }

            let kNum:Int = string.characters.count - 1
            let mutatingText = NSMutableAttributedString(string: string)
            
            mutatingText.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSRange(location:kNum,length:1))
            lbFat.attributedText = mutatingText
        }
        
        if let caloPerDay = UserDataManager.sharedInstance.estimatedCaloPerDay(){
            self.caloPerDay = caloPerDay
            if let str = caloPerDay.roundToString(){
                let string = "\(str) kcal"
                let kNum:Int = string.characters.count - 4
                let mutatingText = NSMutableAttributedString(string: string)
                
                mutatingText.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSRange(location:kNum,length:4))
                lbCalo.attributedText = mutatingText

            }
        }
    }
    
    func addNormalView() {
        bikoView?.removeFromSuperview()
        if(normalView == nil){
            _ = Bundle.main.loadNibNamed(AppConfig.Nibs.normalHome, owner: self, options: nil)
        }
        normalView.frame = meterView.frame
        normalView.frame.origin.x = 0
        normalView.frame.origin.y = 0
        meterView.addSubview(normalView)
        reducedCaloIntake?.layer.borderWidth = 2
        reducedCaloIntake?.layer.cornerRadius = 15
        reducedCaloIntake?.layer.borderColor = AppConfig.Colors.totalCaloTarget.cgColor
        reducedCaloIntake?.layer.masksToBounds = true
        
        lbNormal1.adjustsFontSizeToFitWidth = true;
        lbNormal2.adjustsFontSizeToFitWidth = true;
        lbNormal3.adjustsFontSizeToFitWidth = true;
        reducedCaloIntake?.adjustsFontSizeToFitWidth = true;
    }
    
    func addBikoView() {
        reducedCaloIntakeBiko?.adjustsFontSizeToFitWidth = true
        normalView?.removeFromSuperview()
        if(bikoView == nil){
            _ = Bundle.main.loadNibNamed(AppConfig.Nibs.bikoHome, owner: self, options: nil)
        }
        bikoView.frame = meterView.frame
        bikoView.frame.origin.x = 0
        bikoView.frame.origin.y = 0
        meterView.addSubview(bikoView)
        bikoMeter?.setThumbImage(UIImage(named:"oval"), for: .normal)
        
        lbCaloSaving.isHidden = true
    }

    func setCaloIntake(_ value:Double){
        guard (value >= 0) else {
            normalMeter?.setProgress(0, animated: false)
            bikoMeter?.value = 0
            return
        }
        
        normalK?.isHidden      = true
        lbNormal1?.isHidden    = true
        lbNormal2?.isHidden    = true
        lbNormal3?.isHidden    = true
        
        normalMeter?.setProgress(value, animated: true)
        bikoMeter?.value = Float(value)
    }
}

