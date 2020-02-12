//
//  MetronomeViewController.swift
//  Timemark
//
//  Created by Julian Wright on 2/12/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit
import AVFoundation

class MetronomeViewController: UIViewController {

    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var metronomeImage: UIImageView!
    
    var timer = Timer()
    var imageTimer = Timer()
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(metronomeBeat), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let sliderValue = Int(round(sender.value))
        bpmLabel.text = String(sliderValue) + " bpm"
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: (TimeInterval(60 / Double(sliderValue))), target: self, selector: #selector(metronomeBeat), userInfo: nil, repeats: true)
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "metronome", withExtension: "mp3") else { return }

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
    
    @objc func metronomeBeat() {
        metronomeImage.image = UIImage(named: "MetronomeOn")
        playSound()
        imageTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(imageOff), userInfo: nil, repeats: false)
    }
    
    @objc func imageOff() {
        metronomeImage.image = UIImage(named: "ClockBG")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
