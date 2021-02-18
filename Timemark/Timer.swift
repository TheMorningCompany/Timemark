//
//  Timer.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 2/8/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import AVFoundation
import UIKit

class TimerView: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    let notificationManager = LocalNotificationManager()
    
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    var player: AVAudioPlayer?
   
    let notification = UINotificationFeedbackGenerator()
    var time = Timer()
    
    @IBOutlet weak var fieldm: UITextField!
    @IBOutlet weak var fields: UITextField!
    
    var fieldText = "0015"
    var secs = 15
    var mins = 0
    
    var minsCountdown = 0
    var totalCountdown = 15
    
//    var initialTime:Int = 5
//    var currentTime:Int = 0
    var startTime:Date = Date()
    var endTime:Date = Date()
    var timerStopped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide tabBar shadow
        self.tabBarController!.tabBar.layer.borderWidth = 0.50
        self.tabBarController!.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
        
        startButton.isEnabled = true
        stopButton.isEnabled = true
        pauseButton.isEnabled = false
        
        
        //Picker
        fieldm.delegate = self
        fields.delegate = self
        
        fieldm.clearsOnBeginEditing = true
        fields.clearsOnBeginEditing = true
        
        fieldm.clearsOnInsertion = true
        fields.clearsOnInsertion = true
        
        fieldm.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
        fields.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
//
//        fieldm.becomeFirstResponder()
        
    }
    
    func runTimer() {
        let delay = Int(startTime.distance(to: endTime))
        notificationManager.addNotification(title: "Your alarm finished", delay: delay)
        notificationManager.schedule()
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func playSound() {
        
        if let soundName = UserDefaults.standard.string(forKey: "alarm_name") {
            guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }

            do {
                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                /* iOS 10 and earlier require the following line:
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                guard let player = player else { return }

                player.prepareToPlay()
                
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    @objc private func editingChanged(sender: UITextField) {

        if let text = sender.text, text.count >= 3 {
            sender.text = String(text.dropLast(text.count - 2))
            return
        }
        if fieldm.text!.count >= 2 {
            
            mins = Int(fieldm.text!)!
            minsCountdown = mins * 60
            
            secs = Int(fields.text!)!
            totalCountdown = mins + minsCountdown
            
            fieldm.resignFirstResponder()
            fields.becomeFirstResponder()
            let colon = ":"
            
            let userVisible = String(mins)+colon+String(secs)
            timeLabel.text = String(mins)+colon+String(secs)
            
            UserDefaults.standard.set(userVisible, forKey: "timer1")
        }
        if fields.text!.count >= 2 {
            fields.resignFirstResponder()
            
            mins = Int(fieldm.text!)!
            minsCountdown = mins * 60
            
            secs = Int(fields.text!)!
            totalCountdown = secs + minsCountdown
            let colon = ":"
            
            let userVisible = String(mins)+colon+String(secs)
            timeLabel.text = String(mins)+colon+String(secs)
            
            UserDefaults.standard.set(userVisible, forKey: "timer1")
        }
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        time.invalidate()
        if (!timerStopped) {
            startTime = Date()
            endTime = Date() + Double(totalCountdown)
        }
        timerStopped = false
        timeLabel.text = calculateTimeString(currentTime: Int(round(endTime.timeIntervalSinceNow)))
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
        timeLabel.text = String(Int(round(endTime.timeIntervalSinceNow)))
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        stopButton.isEnabled = true
        timerStopped = false
        if let audioPlayer = player {
            if (audioPlayer.isPlaying) {
                audioPlayer.stop()
            }
        }
        endBackgroundTask()
    }
    
    @objc func updateTimer() {
        if (Int(round(endTime.timeIntervalSinceNow)) == 0) {
            time.invalidate()
            notification.notificationOccurred(.error)
            notification.notificationOccurred(.success)
            notification.notificationOccurred(.warning)
            playSound()
        }
        timeLabel.text = calculateTimeString(currentTime: Int(round(endTime.timeIntervalSinceNow)))
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
    
    func registerBackgroundTask() {
      backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
        self?.endBackgroundTask()
      }
      assert(backgroundTask != .invalid)
    }
      
    func endBackgroundTask() {
      print("Background task ended.")
      UIApplication.shared.endBackgroundTask(backgroundTask)
      backgroundTask = .invalid
    }


}

extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
}

