//
//  MetronomeViewController.swift
//  Timemark
//
//  Created by Julian Wright on 2/12/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class MetronomeViewController: UIViewController {

    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var metronomeImage: UIImageView!
    
    var timer = Timer()
    var imageTimer = Timer()
    
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
    
    @objc func metronomeBeat() {
        metronomeImage.image = UIImage(named: "MetronomeOn")
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
