//
//  TimerFourViewController.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 2/16/21.
//  Copyright © 2021 Zeqe Golomb. All rights reserved.
//

import UIKit

class TimerFourViewController: UITableViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    @IBAction func picker1Ended(_ sender: Any) {
        let timer1label = UserDefaults.standard.string(forKey: "timer1")
        label1.text = timer1label
        
    }
    @IBAction func picker2Ended(_ sender: Any) {
        
    }
    @IBAction func picker3Ended(_ sender: Any) {
        
    }
    @IBAction func picker4Ended(_ sender: Any) {
        
    }
    
    @IBAction func goToTimer1(_ sender: Any) {
        performSegue(withIdentifier: "goToMainTimer", sender: self)
    }
    
    
}
