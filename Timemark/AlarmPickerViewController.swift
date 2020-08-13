//
//  AlarmPickerViewController.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 3/31/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class AlarmPickerViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func softAlarmPressed() {
        setAlarm(alarm: "soft")
    }
    
    @IBAction func slowmotionAlarmPressed() {
        setAlarm(alarm: "slowmotion")
    }
    
    @IBAction func orchestralAlarmPressed() {
        setAlarm(alarm: "orchestral")
    }
    
    @IBAction func layeredAlarmPressed() {
        setAlarm(alarm: "layered")
    }
    
    func setAlarm(alarm: String) {
        UserDefaults.standard.set(alarm, forKey: "alarm_name")
        UserDefaults.standard.synchronize()
    }
    
    

}
