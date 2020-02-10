//
//  Timer.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 2/8/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class TimerView: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var time = Timer()
    
    var initialTime:Double = 0.0
    var currentTime:Double = 0.0
    var timerStopped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        timeLabel.isHidden = true
        // Do any additional setup after loading the view.
        
    }
    
    func runTimer() {
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        time.invalidate()
        initialTime = timePicker.countDownDuration
        currentTime = initialTime
        runTimer()
        timerStopped = false
        timePicker.isHidden = true
        timeLabel.isHidden = false
        timeLabel.text = String(currentTime)
    }
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        if !timerStopped {
            time.invalidate()
            timerStopped = true
        } else {
            runTimer()
            timerStopped = false
            
        }
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        time.invalidate()
        currentTime = initialTime
        timeLabel.text = String(currentTime)
        timePicker.isHidden = false
        timeLabel.isHidden = true
    }
    
    @objc func updateTimer() {
        currentTime -= 1
        timeLabel.text = String(currentTime)
    }

}

