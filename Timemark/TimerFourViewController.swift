//
//  TimerFourViewController.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 2/16/21.
//  Copyright © 2021 Zeqe Golomb. All rights reserved.
//

import UIKit

class TimerFourViewController: UITableViewController {
    
    @IBOutlet weak var picker1: UIDatePicker!
    @IBOutlet weak var picker2: UIDatePicker!
    @IBOutlet weak var picker3: UIDatePicker!
    @IBOutlet weak var picker4: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    @IBAction func picker1Ended(_ sender: Any) {
        UserDefaults.standard.set(picker1.countDownDuration, forKey: "timer1")
    }
    @IBAction func picker2Ended(_ sender: Any) {
        UserDefaults.standard.set(picker2.countDownDuration, forKey: "timer2")
    }
    @IBAction func picker3Ended(_ sender: Any) {
        UserDefaults.standard.set(picker3.countDownDuration, forKey: "timer3")
    }
    @IBAction func picker4Ended(_ sender: Any) {
        UserDefaults.standard.set(picker4.countDownDuration, forKey: "timer4")
    }
    
    @IBAction func goToTimer1(_ sender: Any) {
        performSegue(withIdentifier: "goToMainTimer", sender: self)
    }
    
    
}
