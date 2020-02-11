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
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
   
    let notification = UINotificationFeedbackGenerator()
    var time = Timer()
    
    var initialTime:Int = 0
    var currentTime:Int = 0
    var timerStopped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        timeLabel.isHidden = true
        startButton.isEnabled = true
        stopButton.isEnabled = true
        pauseButton.isEnabled = false
        // Do any additional setup after loading the view.
        
    }
    
    func runTimer() {
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        time.invalidate()
        if (!timerStopped) {
            initialTime = Int(timePicker.countDownDuration)
            currentTime = initialTime
        }
        timerStopped = false
        timePicker.isHidden = true
        timeLabel.isHidden = false
        timeLabel.text = calculateTimeString(currentTime: currentTime)
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        stopButton.isEnabled = true
        runTimer()
    }
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        if !timerStopped {
            time.invalidate()
            timerStopped = true
            startButton.isEnabled = true
            pauseButton.isEnabled = false
            stopButton.isEnabled = true
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
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        stopButton.isEnabled = true
        timerStopped = false
    }
    
    @objc func updateTimer() {
        if (currentTime > 0) {
            currentTime -= 1
        } else {
            time.invalidate()
            notification.notificationOccurred(.error)
            notification.notificationOccurred(.success)
            notification.notificationOccurred(.warning)
        }
        timeLabel.text = calculateTimeString(currentTime: currentTime)
    }
    
    func calculateTimeString(currentTime: Int) -> String {
        let seconds = currentTime % 60
        let minutes = (currentTime - seconds) / 60
        var returnString = ""
        if (seconds < 10) {
            returnString = String(format: "%d:0%d", minutes, seconds)
        } else {
            returnString = String(format: "%d:%d", minutes, seconds)
        }
        
        return returnString
    }

}

