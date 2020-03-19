//
//  FirstViewController.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 2/7/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {
   
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    var timer = Timer()
    var counter = 0.0
    var isRunning = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide tabBar shadow
        self.tabBarController!.tabBar.layer.borderWidth = 0.50
        self.tabBarController!.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
        
        timeLabel.text = "\(counter)"
        playButton.isEnabled = true
        pauseButton.isEnabled = false
        
    }
    @IBAction func resetButtonDidTouch(_ sender: Any)
    {
        timer.invalidate()
        isRunning = false
        counter = 0
        timeLabel.text = "\(counter)"
        
        playButton.isEnabled = true
        pauseButton.isEnabled = false
    
    }
    
    @IBAction func playButtonDidTouch(_ sender: Any)
    {
        if !isRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            playButton.isEnabled = false
            pauseButton.isEnabled = true
        isRunning = true
        
        }
        
    
    }
    
    @IBAction func pauseButtonDidTouch(_ sender: Any)
    {
        playButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isRunning = false
    
    }
    
    @objc func updateTimer() {
        counter += 0.1
        timeLabel.text = String(format: "%.1f", counter)
        
    }

}

