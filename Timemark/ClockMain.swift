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
    let minutesFormatter = DateFormatter()
    let hoursFormatter = DateFormatter()
    
    @IBOutlet weak var clockView: UIView!
    @IBOutlet weak var secondsHandImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minutesHandImage: UIImageView!
    @IBOutlet weak var hourHandImage: UIImageView!
    
    let impact = UIImpactFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "enable_haptics")
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DateAndTime), userInfo: nil, repeats: true)
        
        self.clockView.layer.cornerRadius = self.clockView.frame.size.width/2
        
        //Hide tabBar shadow
        self.tabBarController!.tabBar.layer.borderWidth = 0.50
        self.tabBarController!.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
        
        
        
        timeFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        secondsFormatter.dateFormat = "ss"
        minutesFormatter.dateFormat = "mm"
        hoursFormatter.dateFormat = "HH"
        
        formatTime()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setClockFace), name: .didChangeClockFace, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setClockFace()
    }
    
    @objc func setClockFace() {
        var faceName: String = ""
        if let clockFace: String = UserDefaults.standard.string(forKey: "clock_face") {
            switch clockFace {
            case "disk":
                faceName = "BG-Disk"
                break
            case "inset":
                faceName = "BG-Inset"
                break
            case "ornamental":
                faceName = "BG-Ornamental"
                break
            case "california":
                faceName = "BG-California"
                break
            default:
                faceName = "BG-Disk"
                break
            }
        }
    }

    @objc func DateAndTime () {
        formatTime()
    }
    
    func formatTime() {
        dateLabel.text = dateFormatter.string(from: Date())
        
        let seconds = Double(secondsFormatter.string(from: Date()))
        let minutes = Double(minutesFormatter.string(from: Date()))
        let hours = Double(hoursFormatter.string(from: Date()))
        
        var secondsAngle = 0.0
        var minsAngle = 0.0
        var hrsAngle = 0.0
        
        hrsAngle = (2 * Double.pi) * (hours! / 12)
        minsAngle = (2 * Double.pi) * (minutes! / 60)
        secondsAngle = (2 * Double.pi) * (seconds! / 60)
        
        minutesHandImage.transform = CGAffineTransform(rotationAngle: CGFloat(minsAngle))
        hourHandImage.transform = CGAffineTransform(rotationAngle: CGFloat(hrsAngle))
        secondsHandImage.transform = CGAffineTransform(rotationAngle: CGFloat(secondsAngle))
        
        //Haptics every minute
        if (seconds == 0) {
            impact.impactOccurred()
        }
    }
}

extension Notification.Name {
    static let didChangeClockFace = Notification.Name("didChangeClockFace")
}
