//
//  Timer.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 2/8/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import AVFoundation
import UIKit

class TimerView: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    let notificationManager = LocalNotificationManager()
    
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    var player: AVAudioPlayer?
   
    let notification = UINotificationFeedbackGenerator()
    var time = Timer()
    
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
        
        timeLabel.isHidden = true
        startButton.isEnabled = true
        stopButton.isEnabled = true
        pauseButton.isEnabled = false
        // Do any additional setup after loading the view.
        
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
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        time.invalidate()
        if (!timerStopped) {
            startTime = Date()
            endTime = Date() + Double(timePicker.countDownDuration)
        }
        timerStopped = false
        timePicker.isHidden = true
        timeLabel.isHidden = false
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
        timePicker.isHidden = false
        timeLabel.isHidden = true
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

    @IBAction func soundOptions(_ sender: Any) {
        // Present options vc here but have sound picker present as well
    }
}
