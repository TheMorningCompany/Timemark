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
    @IBOutlet weak var blurColor: UIImageView!
   
    let impact = UIImpactFeedbackGenerator()
    var timer = Timer()
    var imageTimer = Timer()
    var isPlaying = false
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurColor.isHidden = true
        blurColor.alpha = 0
        //Hide tabBar shadow
        self.tabBarController!.tabBar.layer.borderWidth = 0.50
        self.tabBarController!.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setMetronomeValue(value: Int) {
        bpmSlider.setValue(Float(value), animated: true)
        bpmLabel.text = String(value)
    }
    
    func getMetronomeValue() -> Int {
        return Int(round(bpmSlider.value))
    }
    
    @IBAction func adjustBpmButtonsPressed(_ sender: UIButton) {
        setMetronomeValue(value: getMetronomeValue() + sender.tag)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let sliderValue = Int(round(sender.value))
        setMetronomeValue(value: sliderValue)
    }
    
    @IBAction func sliderFinishedEditing(_ sender: UISlider) {
        if (isPlaying) {
            toggleMetronome()
            toggleMetronome()
        }
    }
    
    @IBAction func tapForToggle(_ sender: UITapGestureRecognizer) {
        toggleMetronome()
    }
    
    func toggleMetronome() {
        if (isPlaying) {
            blurColor.alpha = 1
            UIView.animate(withDuration: 0.5) {
                self.blurColor.alpha = 0
            }
            timer.invalidate()
            isPlaying = false
        } else {
            blurColor.isHidden = false
            blurColor.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.blurColor.alpha = 1
            }
            let sliderValue = Int(round(bpmSlider.value))
            timer = Timer.scheduledTimer(timeInterval: (TimeInterval(60 / Double(sliderValue))), target: self, selector: #selector(metronomeBeat), userInfo: nil, repeats: true)
            isPlaying = true
        }
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

            impact.impactOccurred()
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
        metronomeImage.image = UIImage(named: "Metronome")
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
