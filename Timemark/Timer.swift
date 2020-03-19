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

    
    var player: AVAudioPlayer?
   
    let notification = UINotificationFeedbackGenerator()
    var time = Timer()
    
    var initialTime:Int = 0
    var currentTime:Int = 0
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
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    func playSound() {
        
        if let soundName = UserDefaults.standard.string(forKey: "alarm_name") {
            guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                /* iOS 10 and earlier require the following line:
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                guard let player = player else { return }

                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
        }
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
        if let audioPlayer = player {
            if (audioPlayer.isPlaying) {
                audioPlayer.stop()
            }
        }
    }
    
    @objc func updateTimer() {
        if (currentTime > 0) {
            currentTime -= 1
        } else {
            time.invalidate()
            notification.notificationOccurred(.error)
            notification.notificationOccurred(.success)
            notification.notificationOccurred(.warning)
            playSound()
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

