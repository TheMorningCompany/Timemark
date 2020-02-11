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
    
    @IBOutlet weak var secondsHandImage: UIImageView!
    @IBOutlet weak var setTime: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DateAndTime), userInfo: nil, repeats: true)
    }

    @objc func DateAndTime () {
        let time = DateFormatter()
        let date = DateFormatter()
        let secondsFormatter = DateFormatter()
        
        time.timeStyle = .short
        date.dateStyle = .medium
        secondsFormatter.dateFormat = "ss"
        
        setTime.text = time.string(from: Date())
        
        dateLabel.text = date.string(from: Date())
        
        let seconds = Double(secondsFormatter.string(from: Date()))
        
        let angle = (2 * Double.pi) / 60
        
        secondsHandImage.transform = secondsHandImage.transform.rotated(by: CGFloat(angle))
    }
}
