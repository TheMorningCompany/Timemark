//
//  SecondViewController.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 2/7/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {
    
    
    var time = Timer()
    
    let clock = Clock()
    
    let timeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    let secondsFormatter = DateFormatter()
    
    @IBOutlet weak var secondsHandImage: UIImageView!
    @IBOutlet weak var setTime: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let impact = UIImpactFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "enable_haptics")
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DateAndTime), userInfo: nil, repeats: true)
        
        //Hide tabBar shadow
        self.tabBarController!.tabBar.layer.borderWidth = 0.50
        self.tabBarController!.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
        
        timeFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        secondsFormatter.dateFormat = "ss"
        
        formatTime()
    }

    @objc func DateAndTime () {
        formatTime()
    }
    
    func formatTime() {
        
        setTime.text = timeFormatter.string(from: Date())
        
        dateLabel.text = dateFormatter.string(from: Date())
        
        let seconds = Double(secondsFormatter.string(from: Date()))
        
        var angle = 0.0
        
        angle = (2 * Double.pi) * (seconds! / 60)
        
        secondsHandImage.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        
        if (seconds == 0) {
            impact.impactOccurred() //haptics every minute
        }
    }
}
